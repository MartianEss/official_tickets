require 'barby'
require 'barby/barcode/code_128'
require 'rmagick'
require 'barby/outputter/svg_outputter'

class Ticket < ActiveRecord::Base
  belongs_to :order
  belongs_to :event
  belongs_to :ticket_purchaser

  validates_associated :order

  validates_presence_of :order, :event, :ticket_purchaser

  before_create :set_serial

  def barcode
    barcode = Barby::Code128B.new(self.serial)
    outputter = Barby::SvgOutputter.new(barcode)
    outputter.to_svg
  end

  def self.purchase(order, event)
    self.create_tickets(order, event)
  end

  def self.remaining(tickets_allocation, event)
    (tickets_allocation.allocated - Ticket.where(event: event).count)
  end

  protected

  def self.create_tickets(order, event)
    names = order.names_on_ticket.split(',')
    order.number_of_tickets.times { |i| self.create!(ordered_for: names[i].strip, order: order, event: event, ticket_purchaser: order.ticket_purchaser) }
  end

  def set_serial
    self.serial = "%.3s-%.6d" % [event.title.upcase, (Ticket.where(event: event).count + 1)]
  end
end
