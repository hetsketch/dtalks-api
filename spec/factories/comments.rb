# frozen_string_literal: true

FactoryGirl.define do
  factory :comment do
    text Faker::Lorem.sentence(15)

    association :author, factory: :user
    association :commentable, factory: :topic
  end
end
