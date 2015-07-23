require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe '.purchase' do
    it 'gets the total prices of the tickets'
    it 'attempts to purchase tickets'
  end

  describe '.remaining' do
    let(:event) { Event.create!event_params }
    let(:ticket_purchaser) { TicketPurchaser.create!(email: Faker::Internet.email, password: 'password', password_confirmation: 'password') }

    let(:tickets_allocation) { TicketsAllocation.create!(name: 'Early Bird', price: 11.12, allocated: 3, event: event) }
    let(:order) { Order.create!(ticket_purchaser: ticket_purchaser, tickets_allocation: tickets_allocation, number_of_tickets: 3) }

    it 'show the correct amount of tickets left' do
      2.times { |i| Ticket.create!(event: event, order: order) }

      expect(Ticket.remaining(tickets_allocation, event)).to eql(1)
    end
  end
end
