class Order < ActiveRecord::Base
  belongs_to :ticket_purchaser

  has_one :tickets_allocation

  has_many :tickets
  has_one :event

  validate :has_enough_tickets_for_sale?, on: :create

  validates_associated :ticket_purchaser
  validates_associated :tickets_allocation

  before_save :set_total_price

  def process(payment_method, tickets_allocation, ticket_purchaser)
    self.ticket_purchaser = ticket_purchaser
    self.tickets_allocation = tickets_allocation

    if save and payment_result = payment_successful?(payment_method)
      event = self.tickets_allocation.event
      tickets.purchase(self, event)
    else
      payment_result || false
    end
  end

  protected


  def payment_successful?(payment_method)
    Braintree::Transaction.sale(
      amount: self.total_price.to_s,
      payment_method_nonce: payment_method
    )
  end

  def set_total_price
    number_of_tickets.times { self.total_price += tickets_allocation.price }
  end

  def has_enough_tickets_for_sale?
    if number_of_tickets > (tickets_allocation.allocated - tickets.count)
      errors.add(:self, 'Not enough tickets available')
    end
  end
end
