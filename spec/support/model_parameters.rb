module OfficialTickets
  module ModelParams
    def event_params(overrides={})
      params = {
        title:  Faker::Lorem.word,
        description:  Faker::Lorem.words.join(' '),
        contact_number: Faker::PhoneNumber.phone_number,

        genre_id: 1,
        dress_code_id: 1,
        event_type_id: 1,

        venue: Faker::Lorem.words(3).join(' '),
        address_line1: Faker::Address.street_address,
        town_city: Faker::Address.city,
        post_code: Faker::Address.postcode,

        date_from: Faker::Date.between(Date.today, Date.today.next_year),
        date_to: Faker::Date.between(Date.today.tomorrow, Date.today.next_year),
        time_from: Faker::Time.between(Time.now, Time.now.next_year, :all),
        time_to: Faker::Time.between(Time.now.tomorrow, Time.now.next_year, :all),

        approved: false
      }

      params.merge(overrides)
    end
  end
end

RSpec.configure do |c|
  c.include OfficialTickets::ModelParams
end
