# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'fields' do
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to belong_to(:author).class_name('User').with_foreign_key('user_id') }
    it { is_expected.to belong_to(:company).counter_cache(true) }
  end
end
