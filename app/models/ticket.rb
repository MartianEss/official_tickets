class Ticket < ActiveRecord::Base
  belongs_to :order
  belongs_to :event
  belongs_to :ticket_purchaser

  validates_associated :order

  validates_presence_of :order, :event, :ticket_purchaser

  def self.purchase(order, event)
    begin
      self.create_tickets(order, event)
      self.make_payment(order, event)
    rescue Exception
      false
    end
  end

  def self.make_payment(order, event)
  end

  def self.remaining(tickets_allocation, event)
    (tickets_allocation.allocated - Ticket.where(event: event).count)
  end

  protected

  def self.create_tickets(order, event)
    order.number_of_tickets.times { self.create!(order: order, event: event, ticket_purchaser: order.ticket_purchaser) }
  end
end
