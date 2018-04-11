# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe 'validations' do
    # Presence
    %i[email username].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    # Uniqueness
    it { is_expected.to validate_uniqueness_of(:username) }

    # Length
    it { is_expected.to validate_length_of(:email).is_at_least(5) }
    it { is_expected.to validate_length_of(:email).is_at_most(100) }
    it { is_expected.to validate_length_of(:username).is_at_least(2) }
    it { is_expected.to validate_length_of(:username).is_at_most(30) }

    %i[first_name last_name position city].each do |field|
      it { is_expected.to validate_length_of(field).is_at_least(2) }
      it { is_expected.to validate_length_of(field).is_at_most(100) }
    end

    it { is_expected.to validate_length_of(:bio).is_at_least(10) }
    it { is_expected.to validate_length_of(:bio).is_at_most(300) }

    describe 'links' do
      let(:user) { build(:user) }

      context 'with valid links' do
        it 'is valid' do
          user.links << 'http://yourawesomeurl.com'
          user.links << 'https://newawesomeurl.com'
          expect(user).to be_valid
        end
      end

      context 'with invalid links' do
        it 'is invalid' do
          user.links << 'http://yourawesomeurl.com'
          user.links << 'just some text'
          expect(user).not_to be_valid
        end
      end
    end
  end

  describe 'associations' do
    %i[topics comments].each do |field|
      it { is_expected.to have_many(field).dependent(:destroy) }
    end

    it { is_expected.to have_many(:participants) }
    it { is_expected.to have_many(:events).through(:participants) }
    it { is_expected.to belong_to(:company).counter_cache(:employees_count) }
  end

  describe 'avatar uploader' do
    subject { user.valid? }

    context 'with valid avatar' do
      let(:user) { build(:user, :with_avatar) }

      it 'validates avatar' do
        subject

        expect(user.errors).to be_empty
      end
    end

    context 'when avatar size is more than 400x400' do
      let(:avatar) { File.open('spec/support/test_files/big_width_avatar.jpeg') }
      let(:user) { build(:user, avatar: avatar) }

      it 'does not validate user' do
        subject

        expect(user.errors.messages[:avatar].include?('is too wide (max is 400 px)')).to be_truthy
        expect(user.errors.messages[:avatar].include?('is too tall (max is 400 px)')).to be_truthy
      end
    end

    context 'when size is more than 100kb' do
      let(:avatar) { File.open('spec/support/test_files/big_size_avatar.jpg') }
      let(:user) { build(:user, avatar: avatar) }

      it 'does not validate user' do
        subject

        expect(user.errors.messages[:avatar].include?('is too large (max is 100 Kb)')).to be_truthy
      end
    end
  end

  describe 'callbacks' do
    describe '#assign_default_role' do
      context 'when new user created' do
        let(:user) { build(:user) }

        it 'sets user role to new user' do
          user.save
          expect(user.has_role?(:user)).to be_truthy
        end
      end
    end
  end

  describe '#add_admin_role' do
    it 'adds admin role to user' do
      user.add_admin_role
      expect(user.has_role?(:admin)).to be_truthy
    end
  end
end
