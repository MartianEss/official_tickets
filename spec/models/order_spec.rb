require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:event) { Event.create!event_params }
  let(:tickets_allocation) { TicketsAllocation.create!(name: 'Early Bird', price: 11.12, allocated: 3, event: event) }
  let(:ticket_purchaser) { TicketPurchaser.create!(email: Faker::Internet.email, password: 'password', password_confirmation: 'password') }

  subject { described_class.new(ticket_purchaser: ticket_purchaser, tickets_allocation: tickets_allocation, number_of_tickets: 3, names_on_ticket: 'foo, bar baz, joe smith') }

  it 'has ticket information' do
    expect(subject.tickets_allocation).to eql(tickets_allocation)
  end

  it 'belongs to a ticket purchaser' do
    expect(subject.ticket_purchaser).to eql(ticket_purchaser)
  end

  it 'relies on the allocated ticket number from events' do
    allow(tickets_allocation).to receive(:allocated).and_return 2
    expect(subject).to be_invalid
  end

  it 'must have the equal number of names to tickets being purchased' do
    subject.names_on_ticket = 'foo, bar baz, joe smith'

    expect(subject).to be_valid
  end

  describe '#save' do
    it 'stores the total price' do
      subject.save

      expect(subject.total_price).to eql(33.36)
    end

    it 'must have the same number of tickets to names on tickets' do
      subject.names_on_ticket = 'foo, bar baz'

      expect(subject).to be_invalid
      expect(subject.errors.messages[:names_on_ticket]).to include('Must add 3 names, only have 2')
    end
  end

  describe '#process' do
    let(:nonce) { 'nonce-from-the-client' }

    it 'checks tickets are available' do
      expect(subject).to receive(:has_enough_tickets_for_sale?).and_return true
      subject.process(nonce, tickets_allocation, ticket_purchaser)
    end

    it 'saves the order' do
      expect(subject).to receive(:save).and_return(true).at_least(:once)
      subject.process(nonce, tickets_allocation, ticket_purchaser)
    end

    it 'purchase tickets' do
      allow(subject).to receive(:save).and_return true

      expect(subject.tickets).to receive(:purchase).and_return true
      subject.process(nonce, tickets_allocation, ticket_purchaser)
    end

    context 'failed order' do
      let(:tickets_allocation) { TicketsAllocation.create!(name: 'Early Bird', price: 11.12, allocated: 2, event: event) }

      subject { described_class.new(ticket_purchaser: ticket_purchaser, tickets_allocation: tickets_allocation, number_of_tickets: 3) }

      it 'event does not have enough tickets' do
        expect(subject.process(nonce, tickets_allocation, ticket_purchaser)).to be_falsey
      end

      it 'does not save the order' do
        allow(subject).to receive(:save).and_return false

        expect(subject.tickets).not_to receive(:purchase)
        subject.process(nonce, tickets_allocation, ticket_purchaser)
      end

      context 'payment failed' do
        it 'card declined'
      end
    end
  end

  describe '#generate_tickets' do
    it 'creates the appropriate number of tickets'
  end
end
