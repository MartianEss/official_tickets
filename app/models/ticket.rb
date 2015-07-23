class Ticket < ActiveRecord::Base
  belongs_to :order
  belongs_to :event

  def self.purchase(order)
    begin
      order.number_of_tickets.times do |i|
        self.create!(order: order, event: order.event)
      end
      self.tickets.reload
      true
    rescue Exception
      false
    end
  end

  def self.remaining(tickets_allocation, event)
    (tickets_allocation.allocated - Ticket.where(event: event).count)
  end
end
