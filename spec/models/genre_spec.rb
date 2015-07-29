require 'rails_helper'

RSpec.describe Genre, type: :model do
  subject { described_class }

  it 'can get a list of all existing genres' do
    expect(subject.all).to be_an(ActiveResource::Collection)
  end
end
