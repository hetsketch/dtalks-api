# frozen_string_literal: true

FactoryBot.define do
  factory :participant do
    user
    event
  end
end
