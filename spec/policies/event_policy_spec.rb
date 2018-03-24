# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventPolicy do
  subject { described_class }

  let(:author) { build(:user) }
  let(:admin) { build(:user, :admin) }
  let(:simple_user) { build(:user) }
  let(:event) { build(:event, author: author) }

  permissions :update?, :destroy? do
    it 'grants access if user is author of event' do
      expect(subject).to permit(author, event)
    end

    it 'grants access if user is admin' do
      expect(subject).to permit(author, event)
    end

    it 'denies access if user is not author of event' do
      expect(subject).not_to permit(simple_user, event)
    end
  end

  permissions :create? do
    it 'grants access to users' do
      expect(subject).to permit(simple_user, event)
    end
  end
end
