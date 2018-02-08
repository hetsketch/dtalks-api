# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe 'fields' do
    # Associations
    %i[user event].each do |field|
      it { is_expected.to belong_to(field) }
    end
  end
end
