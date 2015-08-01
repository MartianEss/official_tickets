class TicketsAllocation < ActiveRecord::Base
  belongs_to :event
  belongs_to :order

  has_many :tickets, dependent: :destroy

  def remaining
    Ticket.remaining(self, self.event)
  end
end
