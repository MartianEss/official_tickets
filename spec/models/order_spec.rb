require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:event) { Event.create!event_params }
  let(:tickets_allocation) { TicketsAllocation.create!(name: 'Early Bird', price: 11.12, allocated: 2, event: event) }
  let(:ticket_purchaser) { TicketPurchaser.create!(email: Faker::Internet.email, password: 'password', password_confirmation: 'password') }

  subject { described_class.new(ticket_purchaser: ticket_purchaser, tickets_allocation: tickets_allocation, number_of_tickets: 3) }

  it 'has ticket information' do
    expect(subject.tickets_allocation).to eql(tickets_allocation)
  end

  it 'belongs to a ticket purchaser' do
    expect(subject.ticket_purchaser).to eql(ticket_purchaser)
  end

  it 'relies on the allocated ticket number from events' do
    expect(subject).to be_invalid
  end

  describe '#process' do
    it 'checks tickets are available'
    it 'processes payment'
    it 'creates the right number of tickets'
    it 'generates the tickets'

    context 'failed order' do
      it 'event does not have enough tickets' do
        allow(subject).to receive(:has_enough_tickets_for_sale?).and_return false
        expect(subject.process).to eql(false)
      end
    end
  end

  describe '#generate_tickets' do
    it 'creates the appropriate number of tickets'
  end
end