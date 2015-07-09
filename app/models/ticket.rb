class Ticket < ActiveRecord::Base
  belongs_to :order
  belongs_to :event
end
