# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'fields' do
    let!(:event) { create(:event) }

    # Presence
    %i[title text author start_time end_time].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    # Uniqueness
    %i[title].each do |field|
      it { is_expected.to validate_uniqueness_of(field) }
    end

    # Length
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }

    it { is_expected.to validate_length_of(:text).is_at_least(100) }
    it { is_expected.to validate_length_of(:text).is_at_most(10_000) }

    # Associations
    it { is_expected.to belong_to(:author).class_name('User').with_foreign_key('user_id') }
    it { is_expected.to have_many(:participants).counter_cache(:participants_count) }
    it { is_expected.to have_many(:users).through(:participants) }
  end

  describe 'scopes' do
    let!(:future_event1) { create(:event, :future) }
    let!(:future_event2) { create(:event, :future) }
    let!(:future_event3) { create(:event, :future) }

    let!(:passed_event1) { create(:event, :passed) }
    let!(:passed_event2) { create(:event, :passed) }
    let!(:passed_event3) { create(:event, :passed) }

    describe '.passed' do
      subject { Event.passed }

      it 'returns only passed events' do
        is_expected.to include(passed_event1, passed_event2, passed_event3)
      end
    end

    describe '.future' do
      subject { Event.future }

      it 'returns only passed events' do
        is_expected.to include(future_event1, future_event2, future_event3)
      end
    end
  end
end
