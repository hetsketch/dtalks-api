# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe 'fields' do
    # Associations
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event).counter_cache(:participants_count) }
  end
end
