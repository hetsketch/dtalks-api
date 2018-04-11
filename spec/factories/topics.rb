# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    sequence(:title) { |n| "#{n}#{Faker::Lorem.sentence}" }
    sequence(:text)  { |n| "#{n}#{Faker::Lorem.paragraphs}" }

    association :author, factory: :user

    after(:create) { |topic| topic.update(tag_list: create_list(:tag, 5)) }
  end
end
