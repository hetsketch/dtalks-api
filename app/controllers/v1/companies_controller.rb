# frozen_string_literal: true

class V1::CompaniesController < ApplicationController
  def index
  end

  def show
  end

  def update
  end

  def create
  end

  def delete
  end

  private

  def company_params
    params.require(:company).permit(:name, :city, :info)
  end
end
