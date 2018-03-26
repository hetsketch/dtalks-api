# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'fields' do
    let!(:company) { create(:company) }

    # Presence
    %i[name city info owner logo rating].each do |field|
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
    it { is_expected.to have_many(:vacancies).dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  describe 'logo uploader' do
    subject { company }

    context 'when logo valid' do
      let(:company) { build(:company) }

      it { is_expected.to be_valid }
    end

    context 'when logo size is more than 200kb' do
      let(:big_image) { File.open('spec/support/test_files/big_size_avatar.jpg') }
      let(:company) { build(:company, logo: big_image) }

      it 'is invalid' do
        expect(company).not_to be_valid
        expect(company.errors).to be_present
        expect(company.errors.messages[:logo]).to include('is too large (max is 200 Kb)')
      end
    end

    context 'when logo dimensions is more than 300x300' do
      let(:big_image) { File.open('spec/support/test_files/big_width_avatar.jpeg') }
      let(:company) { build(:company, logo: big_image) }

      it 'is invalid' do
        expect(company).not_to be_valid
        expect(company.errors).to be_present
        expect(company.errors.messages[:logo]).to include('is too tall (max is 300 px)', 'is too wide (max is 300 px)')
      end
    end
  end

  describe '.order_by' do
    subject { Company.order_by(value) }

    let(:company1) { create(:company_with_employees, employees_count: 1, rating: 3, vacancies_count: 2) }
    let(:company2) { create(:company_with_employees, employees_count: 2, rating: 2, vacancies_count: 3) }
    let(:company3) { create(:company_with_employees, employees_count: 3, rating: 1, vacancies_count: 1) }

    context 'when value is `rating`' do
      let(:value) { 'rating' }

      it 'returns companies ordered by rating' do
        expect(subject).to eq [company1, company2, company3]
      end
    end

    context 'when value is `employees`' do
      let(:value) { 'employees' }

      it 'returns companies ordered by employees' do
        expect(subject).to eq [company3, company2, company1]
      end
    end

    context 'when value is `vacancies`' do
      let(:value) { 'vacancies' }

      it 'returns companies ordered by vacancies' do
        expect(subject).to eq [company2, company1, company3]
      end
    end

    context 'when value is nil' do
      let(:value) { nil }

      it 'returns companies ordered by employees' do
        expect(subject).to eq [company3, company2, company1]
      end
    end

    context 'when value is anything else' do
      let(:value) { 'abra' }

      it 'returns companies ordered by employees' do
        expect(subject).to eq [company3, company2, company1]
      end
    end
  end
end
