# frozen_string_literal: true

FactoryGirl.define do
  factory :event do
    sequence(:title) { |n| "#{Faker::Lorem.sentence(3)}#{n}" }
    sequence(:text) { |n| "#{Faker::Lorem.paragraph(5)}#{n}" }
    start_time Faker::Time.backward
    end_time Faker::Time.forward

    association :author, factory: :user

    trait :passed do
      sequence(:start_time) { |n| (Faker::Time.backward - n.hour).to_s }
      sequence(:end_time) { |n| (DateTime.now - n.hour).to_s }
    end

    trait :future do
      sequence(:start_time) { |n| (DateTime.now + n.day).to_s }
      sequence(:end_time) { |n| (Faker::Time.forward - n.day).to_s }
    end
  end
end
