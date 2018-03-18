# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  describe 'fields' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to belong_to(:company).counter_cache(true) }
  end
end
