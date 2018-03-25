# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompanyPolicy do
  subject { described_class }

  let(:regular_user) { build(:user) }
  let(:admin) { build(:user, :admin) }
  let(:company) { build(:company) }
  let(:company_owner) { company.owner }

  permissions :create? do
    it 'grants access to users' do
      expect(subject).to permit(regular_user, company)
    end
  end

  permissions :update?, :destroy? do
    it 'grants access to company owner' do
      expect(subject).to permit(company_owner, company)
    end

    it 'grants access to admin' do
      expect(subject).to permit(admin, company)
    end

    it 'does not grant access to regular user' do
      expect(subject).not_to permit(regular_user, company)
    end
  end
end