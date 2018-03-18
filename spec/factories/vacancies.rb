# frozen_string_literal: true

FactoryGirl.define do
  factory :vacancy do
    sequence(:name) { |n| "#{Faker::Job.title}#{n}" }
  end
end
