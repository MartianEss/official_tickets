class Order < ActiveRecord::Base
  belongs_to :ticket_purchaser

  has_one :tickets_allocation
  has_many :tickets

  validate :has_enough_tickets_for_sale?, on: :create

  validates_associated :ticket_purchaser
  validates_associated :tickets_allocation

  before_save :set_total_price

  def process
    if save
      event = self.tickets_allocation.event
      tickets.purchase(self, event)
    else
      false
    end
  end

  protected

  def set_total_price
    number_of_tickets.times { self.total_price += tickets_allocation.price }
  end

  def has_enough_tickets_for_sale?
    if number_of_tickets > (tickets_allocation.allocated - tickets.count)
      errors.add(:self, 'Not enough tickets available')
    end
  end
end
