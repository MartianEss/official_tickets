require 'rails_helper'

RSpec.describe TicketAllocation, type: :model do
  subject { described_class.new(name: 'Early Bird', price: 11.12, allocated: 6, event: event) }
  let(:event) { Event.create(event_params) }

  it 'requires a name' do
    expect(subject.name).to eql('Early Bird')
  end

  it 'requires a price' do
    expect(subject.price).to eql(11.12)
  end

  it 'requires an allocated number of tickets' do
    expect(subject.allocated).to eql(6)
  end

  it 'has an event' do
    expect(subject.event).to eql(event)
  end
end
