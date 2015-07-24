require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:event) { Event.create!event_params }

  let(:ticket_purchaser) do
    TicketPurchaser.create!(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
  end

  let(:tickets_allocation) { TicketsAllocation.create!(name: 'Early Bird', price: 11.12, allocated: 3, event: event) }
  let(:order) { Order.create!(ticket_purchaser: ticket_purchaser, tickets_allocation: tickets_allocation, number_of_tickets: 3) }

  subject { described_class.new(order: order, event: event, ticket_purchaser: ticket_purchaser) }

  it 'has an order' do
    expect(subject.order).to eql order
  end

  it 'has an event' do
    expect(subject.event).to eql event
  end

  it 'has an ticket purchaser' do
    expect(subject.ticket_purchaser).to eql ticket_purchaser
  end

  context 'invalid ticket' do
    it 'does not have a order' do
      allow(subject).to receive(:order).and_return nil

      expect(subject).to be_invalid
      expect(subject.errors.messages[:order]).to include('can\'t be blank')
    end

    it 'does not have a event' do
      allow(subject).to receive(:event).and_return nil

      expect(subject).to be_invalid
      expect(subject.errors.messages[:event]).to include('can\'t be blank')
    end

    it 'does not have a ticket purchaser' do
      allow(subject).to receive(:ticket_purchaser).and_return nil

      expect(subject).to be_invalid
      expect(subject.errors.messages[:ticket_purchaser]).to include('can\'t be blank')
    end
  end

  describe '.purchase' do
    it 'gets the total prices of the tickets' do
      expect(order.total_price).to eql(33.36)
    end

    it 'creates the right number of tickets' do
      Ticket.purchase(order, event)

      expect(order.tickets.count).to eql(3)
    end

    context 'failed purchase' do
      it 'does not create tickets'
    end
  end

  describe '.remaining' do
    it 'show the correct amount of tickets left' do
      2.times { |i| Ticket.create!(event: event, order: order, ticket_purchaser: ticket_purchaser) }

      expect(Ticket.remaining(tickets_allocation, event)).to eql(1)
    end
  end
end
