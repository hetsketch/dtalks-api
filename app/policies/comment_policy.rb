# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    @user.has_role?(:user)
  end

  def update?
    super || @comment.author == @user
  end

  def destroy?
    super || @comment.author == @user
  end
end