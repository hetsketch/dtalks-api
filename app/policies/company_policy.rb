# frozen_string_literal: true

class CompanyPolicy < ApplicationPolicy
  attr_reader :user, :company

  def initialize(user, company)
    @user = user
    @company = company
  end

  def create?
    super || user.has_role?(:user)
  end

  def update?
    super || @company.owner == @user
  end

  def destroy?
    super || @company.owner == @user
  end
end