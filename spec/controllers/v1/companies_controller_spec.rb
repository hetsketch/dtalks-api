# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::CompaniesController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    context 'when companies exist' do
      let!(:company_1) { create(:company_with_employees, employees_count: 1) }
      let!(:company_2) { create(:company_with_employees, employees_count: 2) }
      let!(:company_3) { create(:company_with_employees, employees_count: 3) }

      it_behaves_like 'a success request'
      it 'returns companies ordered by number of employees' do
        subject

        expect(json_data.length).to eq(3)
        expect(json_data[0]['id']).to eq(company_3.id)
        expect(json_data[1]['id']).to eq(company_2.id)
        expect(json_data[2]['id']).to eq(company_1.id)
      end
    end

    context 'when companies are empty' do
      it_behaves_like 'a success request'
      it 'returns empty data array' do
        subject

        expect(json_data).to be_empty
      end
    end
  end

  describe 'GET #show' do
    let(:entity) { create(:company) }

    it_behaves_like 'a show action'
  end

  describe 'PUT #update' do
    let!(:company) { create(:company) }
    let(:company_params) { { id: company.id, name: 'N' * 10 } }

    subject { put :update, params: company_params }

    context 'when user have permissions' do
      let(:user) { create(:user) }

      before { authenticate_user(user) }

      it_behaves_like 'a success request'
      it 'updates existing topic' do
        subject

        expect(json_data).not_to be_empty
        expect(json_data['name']).to eq('N' * 10)
      end
    end

    context 'when user does not have permissions' do
      it_behaves_like 'an unauthenticated user'
    end
  end

  describe 'POST #create' do
    context 'when user have permissions' do
      let(:user) { create(:user) }

      before { authenticate_user(user) }

      it_behaves_like 'a create action' do
        let(:entity_class) { 'Company' }
        let(:invalid_params) { { name: 'A' } }
      end
    end

    context 'when user does not have permissions' do
      subject { post :create, params: attributes_for(:company) }

      it_behaves_like 'an unauthenticated user'
    end
  end

  describe 'DELETE #destroy' do
    let!(:company) { create(:company) }
    let(:company_params) { { id: company.id } }

    subject { delete :destroy, params: company_params }

    context 'when user have permissions' do
      let(:user) { create(:user) }

      before { authenticate_user(user) }

      it_behaves_like 'a success request'
      it 'deletes existing company' do
        subject

        expect(Company.count).to eq(0)
      end
    end

    context 'when user does not have permissions' do
      it_behaves_like 'an unauthenticated user'
    end
  end
end
