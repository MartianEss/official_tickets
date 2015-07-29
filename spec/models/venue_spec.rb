require 'rails_helper'

RSpec.describe Venue, type: :model do
  subject { described_class }

  it 'can get a list of all existing venues' do
    expect(subject.all).to be_an(ActiveResource::Collection)
  end
end

