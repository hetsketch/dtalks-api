# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'fields' do
    let!(:company) { create(:company) }

    # Presence
    %i[name city info owner].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    # Uniqueness
    it { is_expected.to validate_uniqueness_of(:name) }

    # Length
    %i[name city].each do |field|
      it { is_expected.to validate_length_of(field).is_at_least(2) }
      it { is_expected.to validate_length_of(field).is_at_most(50) }
    end

    it { is_expected.to validate_length_of(:info).is_at_most(3000) }

    # Associations
    it { is_expected.to belong_to(:owner).class_name('User').with_foreign_key('user_id') }
    it { is_expected.to have_many(:employees).class_name('User') }
  end
end
