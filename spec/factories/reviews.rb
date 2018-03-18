# frozen_string_literal: true

FactoryGirl.define do
  factory :review do
    sequence(:text) { |n| "#{Faker::SiliconValley.quote}#{n}" }
    author
  end
end
