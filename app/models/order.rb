class Order < ActiveRecord::Base
  belongs_to :ticket_purchaser

  has_one :tickets_allocation

  has_many :tickets, dependent: :destroy
  has_one :event

  validate :has_enough_tickets_for_sale?, on: :create
  validate :have_names_for_tickets, on: :create

  validates_associated :ticket_purchaser
  validates_associated :tickets_allocation

  before_save :set_total_price

  def process(payment_method, tickets_allocation, ticket_purchaser)
    self.ticket_purchaser = ticket_purchaser
    self.tickets_allocation = tickets_allocation
    set_total_price

    Order.transaction do
      if save and payment_result = payment_successful?(payment_method)
        event = self.tickets_allocation.event
        tickets.purchase(self, event)
      else
        payment_result
      end
    end
  end

  protected

  def more_than_one_name_on_ticket?
    names_on_ticket.split(',').count == 1
  end

  def payment_successful?(payment_method)
    result = Braintree::Transaction.sale(
      amount: self.total_price.to_s,
      payment_method_nonce: payment_method
    )
    if result.success?
      save
    else
      result.errors
    end
  end

  def set_total_price
    self.total_price = 0

    number_of_tickets.times { self.total_price += tickets_allocation.price }
  end

  def have_names_for_tickets
    if names_on_ticket.split(',').count != number_of_tickets
      errors.add(:names_on_ticket, "Must add #{number_of_tickets} names, only have #{names_on_ticket.split(',').count}")
    end
  end

  def has_enough_tickets_for_sale?
    if number_of_tickets > (tickets_allocation.allocated - tickets.count)
      errors.add(:self, 'Not enough tickets available')
    end
  end
end
