# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'fields' do
    let!(:event) { create(:event) }

    # Presence
    %i[title text author start_time end_time city].each do |field|
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
    it { is_expected.to have_many(:participants) }
    it { is_expected.to have_many(:users).through(:participants) }
  end

  describe 'scopes' do
    let!(:upcoming_event1) { create(:event, :future) }
    let!(:upcoming_event2) { create(:event, :future) }
    let!(:upcoming_event3) { create(:event, :future) }

    let!(:past_event1) { create(:event, :past) }
    let!(:past_event2) { create(:event, :past) }
    let!(:past_event3) { create(:event, :past) }

    describe '.past' do
      subject { Event.past }

      it 'returns only passed events' do
        is_expected.to include(past_event1, past_event2, past_event3)
      end
    end

    describe '.upcoming' do
      subject { Event.upcoming }

      it 'returns only passed events' do
        is_expected.to include(upcoming_event1, upcoming_event2, upcoming_event3)
      end
    end

    describe '.city_events' do
      let!(:moscow_events) { create_list(:event, 2, city: 'Moscow') }
      let!(:spb_events) { create_list(:event, 2, city: 'Saint P.') }

      context 'when one city passed' do
        subject { Event.city_events(['Moscow']) }

        it 'returns events by one city' do
          expect(subject.length).to eql(2)
          is_expected.to include(moscow_events.first, moscow_events.second)
          is_expected.to_not include(spb_events.first, spb_events.second)
        end
      end

      context 'when multiple cities passed' do
        subject { Event.city_events(['Moscow', 'Saint P.']) }

        it 'returns events by multiple cities' do
          expect(subject.length).to eql(4)
          is_expected.to include(moscow_events.first, moscow_events.second, spb_events.first, spb_events.second)
        end
      end
    end

    describe '.group_by_day' do
      let(:events) do
        build_list(:event, 2, start_time: '2018-02-25') + build_list(:event, 3, start_time: '2018-02-26')
      end

      subject { Event.group_by_day(events) }

      it 'returns grouped events by date' do
        expect(subject.length).to eql(2)
        expect(subject['2018-02-25'].length).to eql(2)
        expect(subject['2018-02-26'].length).to eql(3)
      end
    end
  end
end
