require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { described_class.create!(event_params) }

  it 'must be valid' do
    expect(subject).to be_valid
  end

  context 'validations' do
    it 'must have a name' do
      subject.title = ''
      expect(subject).to be_invalid
    end

    it 'must have a description' do
      subject.description = ''
      expect(subject).to be_invalid
    end

    it 'must have a dress code' do
      subject.dress_code_id = ''
      expect(subject).to be_invalid
    end

    it 'must have a genre' do
      subject.genre_id = ''
      expect(subject).to be_invalid
    end

    it 'must have an event type' do
      subject.event_type_id = ''
      expect(subject).to be_invalid
    end

    it 'must have a venue name' do
      subject.venue = ''
      expect(subject).to be_invalid
    end

    it 'must have a venue an address line' do
      subject.address_line1 = ''
      expect(subject).to be_invalid
    end

    it 'must have a venue an town or city' do
      subject.town_city = ''
      expect(subject).to be_invalid
    end

    it 'must have a venue an post code' do
      subject.post_code = ''
      expect(subject).to be_invalid
    end

    it 'must have a date from' do
      subject.date_from = nil
      expect(subject).to be_invalid
    end

    it 'must have a date to' do
      subject.date_to = nil
      expect(subject).to be_invalid
    end

    it 'must have a contact number' do
      subject.contact_number = ''
      expect(subject).to be_invalid
    end
  end

  describe '#needs_reapproval?' do
    it 'checks that the event is approved' do
      expect(subject).to receive(:needs_reapproval?).and_return true
      subject.needs_reapproval?
    end

    it 'checks that it requires reapproval' do
      expect(subject).to receive(:approved?).and_return true
      subject.needs_reapproval?
    end
  end

  context 'approved event changed' do
    subject { described_class.create!(event_params(approved: true)) }

    it 'should be approved' do
      expect(subject).to be_approved
    end

    context 'attributes that require reapproval' do
      it 'changes first line of address' do
        subject.update_attribute(:address_line1, Faker::Address.street_address)
        expect(subject).to be_unapproved
      end

      it 'changes second line of address' do
        subject.update_attribute(:address_line2, Faker::Address.street_address)
        expect(subject).to be_unapproved
      end

      it 'changes post code' do
        subject.update_attribute(:post_code, 'E9 2AE')
        expect(subject).to be_unapproved
      end

      it 'changes city' do
        subject.update_attribute(:town_city, 'London')
        expect(subject).to be_unapproved
      end

      it 'changes date from' do
        subject.update_attribute(:date_from, Date.tomorrow)
        expect(subject).to be_unapproved
      end

      it 'changes date to' do
        subject.update_attribute(:date_to, Date.today.next_year)
        expect(subject).to be_unapproved
      end

      it 'changes time from' do
        subject.update_attribute(:time_from, Time.now.next_year)
        expect(subject).to be_unapproved
      end

      it 'changes time to' do
        subject.update_attribute(:time_to, Time.now.next_year)
        expect(subject).to be_unapproved
      end
    end
  end
end
