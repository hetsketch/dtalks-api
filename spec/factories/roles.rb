# frozen_string_literal: true

FactoryGirl.define do
  factory :role do
    trait :admin do
      name :admin
    end

    trait :user do
      name :user
    end
  end
end
