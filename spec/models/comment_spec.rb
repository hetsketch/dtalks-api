# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  %i[text author commentable].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end

  %i[author commentable].each do |field|
    it { is_expected.to belong_to(field) }
  end

  it { is_expected.to validate_length_of(:text).is_at_most(2000) }
end
