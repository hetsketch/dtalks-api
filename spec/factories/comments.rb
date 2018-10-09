# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    text Faker::Lorem.sentence(15)

    association :author, factory: :user
    association :commentable, factory: :topic
  end
end
