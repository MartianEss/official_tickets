module OfficialTickets
  module ModelParams
    def event_params(overrides={})
      params = {
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

        ticket_type: Faker::Lorem.word,
        tickets_allocated: rand(1000),
        price: Faker::Commerce.price,

        approved: false
      }

      params.merge(overrides)
    end
  end
end

RSpec.configure do |c|
  c.include OfficialTickets::ModelParams
end
