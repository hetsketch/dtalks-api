# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def create?
    @user.has_role?(:user)
  end

  def update?
    @user.has_role?(:admin) || (@user.has_role?(:user) && @event.author == @user)
  end

  def destroy?
    @user.has_role?(:admin) || (@user.has_role?(:user) && @event.author == @user)
  end
end

