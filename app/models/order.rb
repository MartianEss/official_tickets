class Order < ActiveRecord::Base
  belongs_to :ticket_purchaser

  has_one :tickets_allocation

  has_many :tickets, dependent: :destroy
  has_one :event

  validate :validate_tickets_remaiing, on: :create
  validate :validate_number_of_tickets, on: :create

  validates_associated :ticket_purchaser
  validates_associated :tickets_allocation

  before_validation :set_total_price

  after_save :create_tickets, on: :create

  def process(payment_method, tickets_allocation, ticket_purchaser)
    self.ticket_purchaser = ticket_purchaser
    self.tickets_allocation = tickets_allocation
    self.event_id = tickets_allocation.event.id

    Order.transaction do
      if valid? and has_enough_tickets_for_sale?
        payment_result = authorise_payment(payment_method)
        purchase_and_save_order(payment_result)
      else
        false
      end
    end
  end

  def have_names_for_tickets?
    names_on_ticket.split(',').count == number_of_tickets ? true : false
  end

  def has_enough_tickets_for_sale?
    ((tickets_allocation.remaining - number_of_tickets) >= 0) ? true : false
  end

  def authorise_payment(payment_method)
    Braintree::Transaction.sale(
      amount: self.total_price.to_s,
      payment_method_nonce: payment_method
    )
  end

  def more_than_one_name_on_ticket?
    names_on_ticket.split(',').count == 1
  end

  protected

  def purchase_and_save_order(payment_result)
    if payment_result.success?
      self.transaction_code = payment_result.transaction.id
      save
    else
      payment_result
    end
  end

  def set_total_price
    self.total_price = 0

    number_of_tickets.times { self.total_price += tickets_allocation.price }
  end

  def create_tickets
    names = names_on_ticket.split(',')
    number_of_tickets.times { |i| self.tickets.create!(ordered_for: names[i].strip, event_id: self.event_id, ticket_purchaser: ticket_purchaser, tickets_allocation: tickets_allocation) }
  end

  def validate_number_of_tickets
    unless have_names_for_tickets?
      errors.add(:names_on_ticket, "Must add #{number_of_tickets} names, only have #{names_on_ticket.split(',').count}")
    end
  end

  def validate_tickets_remaiing
    unless has_enough_tickets_for_sale?
      errors.add(:order, "Only #{tickets_allocation.remaining} tickets left, you tried to order #{number_of_tickets}")
    end
  end
end
