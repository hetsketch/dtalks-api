# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:author, :owner] do
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    sequence(:username) { |n| "#{Faker::Internet.user_name}#{n}" }
    password 'password'
    password_confirmation 'password'

    trait :with_avatar do
      avatar { File.open('spec/support/test_files/valid_avatar.jpg') }
    end

    trait :admin do
      after(:build) do |user|
        user.add_role(:admin)
      end
    end

    after(:build) do |user|
      user.add_role(:user)
    end
  end
end
