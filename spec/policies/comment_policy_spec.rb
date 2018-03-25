# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { described_class }

  let(:simple_user) { build(:user) }
  let(:admin) { build(:user, :admin) }
  let(:comment) { build(:comment) }

  permissions :update?, :destroy? do
    it 'grants access to admins' do
      expect(subject).to permit(admin, comment)
    end

    it 'grants access to author of the comment' do
      expect(subject).to permit(comment.author, comment)
    end

    it 'denies access to another user' do
      expect(subject).not_to permit(simple_user, comment)
    end
  end

  permissions :create? do
    it 'grants access to any user' do
      expect(subject).to permit(simple_user, comment)
    end

    it 'grants access to admins' do
      expect(subject).to permit(admin, comment)
    end
  end
end