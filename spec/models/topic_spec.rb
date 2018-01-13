# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'fields' do
    let!(:topic) { create :topic }

    # Presence
    %i[title text author].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    # Uniqueness
    %i[title text].each do |field|
      it { is_expected.to validate_uniqueness_of(field) }
    end

    # Length
    it { is_expected.to validate_length_of(:title).is_at_least(10) }
    it { is_expected.to validate_length_of(:title).is_at_most(500) }

    it { is_expected.to validate_length_of(:text).is_at_least(100) }
    it { is_expected.to validate_length_of(:text).is_at_most(30_000) }

    # Associations
    it { is_expected.to belong_to :author }
    it { is_expected.to have_many :comments }
  end

  describe 'scopes' do
    context 'returns recently added topic in desc order' do
      subject { Topic.recently_added }

      let!(:topic1) { create(:topic, created_at: DateTime.now + 1) }
      let!(:topic2) { create(:topic, created_at: DateTime.now + 2) }
      let!(:topic3) { create(:topic, created_at: DateTime.now + 3) }

      it { is_expected.to eq [topic3, topic2, topic1] }
      it { is_expected.to have(3).items }
    end
  end

end
