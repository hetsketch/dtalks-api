# frozen_string_literal: true

class TopicPolicy < ApplicationPolicy
  attr_reader :user, :topic

  def initialize(user, topic)
    @user = user
    @topic = topic
  end

  def create?
    @user.has_role?(:user)
  end

  def update?
    @user.has_role?(:admin) || (@user.has_role?(:user) && @topic.author == @user)
  end

  def destroy?
    @user.has_role?(:admin) || (@user.has_role?(:user) && @topic.author == @user)
  end
end