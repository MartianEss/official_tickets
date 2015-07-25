require 'rails_helper'

RSpec.describe Event, type: :model do
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
    let(:event_params) do
      {
        title:  Faker::Lorem.word,
        description:  Faker::Lorem.words.join(' '),
        location: Faker::Address.street_address,
        contact_number: Faker::PhoneNumber.phone_number,

        genre: Faker::Lorem.word,
        dress_code: Faker::Lorem.word,
        date_from: Faker::Date.between(Date.today, Date.today.next_year),
        date_to: Faker::Date.between(Date.today.tomorrow, Date.today.next_year),
        time_from: Faker::Time.between(Time.now, Time.now.next_year, :all),
        time_to: Faker::Time.between(Time.now.tomorrow, Time.now.next_year, :all),

        approved: true
      }
    end

    subject { described_class.create!(event_params) }

    it 'should be approved' do
      expect(subject).to be_approved
    end

    context 'attributes that require reapproval' do
      it 'changes location' do
        subject.update_attribute(:location, 'London')
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
