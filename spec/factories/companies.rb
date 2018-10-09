# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "#{Faker::Company.name} #{n}" }
    city Faker::Address.city
    info Faker::Lorem.paragraph
    logo { File.open('spec/support/test_files/valid_company_logo.png') }
    url Faker::Internet.url
    owner

    factory :company_with_employees do
      transient do
        employees_count 3
      end

      after(:create) do |company, evaluator|
        create_list(:user, evaluator.employees_count, company: company)
      end
    end
  end
end
