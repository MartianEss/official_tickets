require 'barby'
require 'barby/barcode/code_128'
require 'rmagick'
require 'barby/outputter/svg_outputter'

class Ticket < ActiveRecord::Base
  belongs_to :order
  belongs_to :event
  belongs_to :ticket_purchaser
  belongs_to :tickets_allocation

  validates_associated :order

  validates_presence_of :order, :event, :ticket_purchaser

  before_create :set_serial

  def used?
    used ? 'Used' : 'Unused'
  end

  def price
    self.tickets_allocation.price
  end

  def barcode
    barcode = Barby::Code128B.new(self.serial)
    outputter = Barby::SvgOutputter.new(barcode)
    outputter.to_svg
  end

  def self.tickets_purchased(tickets_allocation, event)
    Ticket.where(event: event, tickets_allocation_id: tickets_allocation.id)
  end

  def self.remaining(tickets_allocation, event)
    (tickets_allocation.allocated - self.tickets_purchased(tickets_allocation, event).count)
  end

  protected

  def set_serial
    self.serial = "%6s-%.6d" % [order.transaction_code.upcase, (Ticket.where(event: event).count + 1)]
  end
end
