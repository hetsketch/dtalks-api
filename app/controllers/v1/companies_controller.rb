# frozen_string_literal: true

class V1::CompaniesController < ApplicationController
  before_action :authenticate_v1_user!, except: [:show, :index]

  def index
    @companies = Company.order(employees_count: :desc)
  end

  def show
    @company = company
  end

  def update
    @company = company
    @company.update!(company_params)
    render 'v1/companies/show'
  end

  def create
    @company = Company.new(company_params)
    @company.owner = current_v1_user
    @company.save!
    render status: :created
  end

  def destroy
    company.destroy
    render json: { success: true }, status: :ok
  end

  private

  def company
    Company.find(params[:id])
  end

  def company_params
    params.permit(:name, :city, :info, :logo_data_uri, :url, photos_attributes: [:image_data_uri])
  end
end
