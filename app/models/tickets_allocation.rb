class TicketsAllocation < ActiveRecord::Base
  belongs_to :event
  belongs_to :order

  def remaining
    20
  end
end
