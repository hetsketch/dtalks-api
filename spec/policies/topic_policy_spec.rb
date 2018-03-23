# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopicPolicy do
  subject { described_class }

  let(:author) { build(:user) }
  let(:admin) { build(:user, :admin) }
  let(:simple_user) { build(:user) }
  let(:topic) { build(:topic, author: author) }

  permissions :update?, :delete? do
    it 'grants access if user is author of topic' do
      expect(subject).to permit(author, topic)
    end

    it 'grants access if user is admin' do
      expect(subject).to permit(author, topic)
    end

    it 'denies access if user is not author of topic' do
      expect(subject).not_to permit(simple_user, topic)
    end
  end

  permissions :create? do
    it 'grants access to users' do
      expect(subject).to permit(simple_user, topic)
    end
  end
end