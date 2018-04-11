# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "#{Faker::Lorem.sentence(3)}#{n}" }
    sequence(:text) { |n| "#{Faker::Lorem.paragraph(5)}#{n}" }
    start_time Faker::Time.backward
    end_time Faker::Time.forward
    sequence(:city) { |n| "#{Faker::Address.city}#{n}" }
    sequence(:address) { |n| "#{Faker::Address.street_address}#{n}" }
    free false
    price Faker::Number.positive

    association :author, factory: :user

    trait :past do
      sequence(:start_time) { |n| (Faker::Time.backward - n.hour).to_s }
      sequence(:end_time) { |n| (DateTime.now - n.hour).to_s }
    end

    trait :future do
      sequence(:start_time) { |n| (DateTime.now + n.day).to_s }
      sequence(:end_time) { |n| (Faker::Time.forward - n.day).to_s }
    end

    trait :offline do
      address Faker::Address.street_address
      longitude Faker::Address.longitude
      latitude Faker::Address.latitude
    end

    trait :online do
      online true
    end

    trait :free do
      free true
    end
  end
end
