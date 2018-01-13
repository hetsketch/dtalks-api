# frozen_string_literal: true

FactoryGirl.define do
  factory :company do
    name Faker::Company.name
    city Faker::Address.city
    info Faker::Lorem.sentences

    association :owner, factory: :user
  end
end
