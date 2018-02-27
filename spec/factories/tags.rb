# frozen_string_literal: true

FactoryGirl.define do
  factory :tag, class: ActsAsTaggableOn::Tag do
    sequence(:name) { |n| "#{Faker::GameOfThrones.city}#{n}" }
  end
end