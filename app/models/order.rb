class Order < ActiveRecord::Base
  belongs_to :ticket_purchaser

  has_many :tickets
  belongs_to :event
end
