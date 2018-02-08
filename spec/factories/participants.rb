# frozen_string_literal: true

FactoryGirl.define do
  factory :participant do
    user
    event
  end
end
