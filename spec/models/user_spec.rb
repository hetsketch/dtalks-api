# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  # Presence
  %i[email username].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end

  # Uniqueness
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { is_expected.to validate_uniqueness_of(:username) }

  # Length
  it { is_expected.to validate_length_of(:email).is_at_least(5) }
  it { is_expected.to validate_length_of(:email).is_at_most(100) }
  it { is_expected.to validate_length_of(:username).is_at_least(2) }
  it { is_expected.to validate_length_of(:username).is_at_most(30) }

  %i[first_name last_name position city].each do |field|
    it { is_expected.to validate_length_of(field).is_at_least(2) }
    it { is_expected.to validate_length_of(field).is_at_most(100) }
  end

  it { is_expected.to validate_length_of(:bio).is_at_least(10) }
  it { is_expected.to validate_length_of(:bio).is_at_most(300) }

  # Associations
  %i[topics comments].each do |field|
    it { is_expected.to have_many(field).dependent(:destroy) }
  end

  it { is_expected.to have_many(:participants) }
  it { is_expected.to have_many(:events).through(:participants) }
  it { is_expected.to belong_to(:company).counter_cache(:employees_count) }
end
