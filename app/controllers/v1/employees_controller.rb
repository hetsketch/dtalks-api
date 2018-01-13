# frozen_string_literal: true

class V1::EmployeesController < ApplicationController
  def index
  end

  private

  def employee_params
    params.require(:employee)
  end
end
