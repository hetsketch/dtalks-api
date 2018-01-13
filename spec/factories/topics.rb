# frozen_string_literal: true

FactoryGirl.define do
  factory :topic do
    sequence(:title) { |n| "#{n}#{Faker::Lorem.sentence}" }
    sequence(:text)  { |n| "#{n}#{Faker::Lorem.paragraphs}" }

    association :author, factory: :user
  end
end
