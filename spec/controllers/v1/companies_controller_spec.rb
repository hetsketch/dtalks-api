# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::CompaniesController, type: :controller do
  describe 'GET #index' do
    subject { get :index, params: params }
    let(:params) { {} }

    context 'when companies exist' do
      let!(:company_1) { create(:company_with_employees, employees_count: 1, rating: 3, vacancies_count: 2) }
      let!(:company_2) { create(:company_with_employees, employees_count: 2, rating: 2, vacancies_count: 1) }
      let!(:company_3) { create(:company_with_employees, employees_count: 3, rating: 1, vacancies_count: 3) }

      it_behaves_like 'a success request'
      it 'returns companies ordered by number of employees' do
        subject

        expect(json_data.length).to eq(3)
        expect(json_data[0]['id']).to eq(company_3.id)
        expect(json_data[1]['id']).to eq(company_2.id)
        expect(json_data[2]['id']).to eq(company_1.id)
      end

      context 'when filter sets to `rating`' do
        let(:params) { { order_by: 'rating' } }

        it 'returns companies ordered by rating' do
          subject

          expect(json_data[0]['id']).to eq(company_1.id)
          expect(json_data[1]['id']).to eq(company_2.id)
          expect(json_data[2]['id']).to eq(company_3.id)
        end
      end

      context 'when filter sets to `vacancies`' do
        let(:params) { { order_by: 'vacancies' } }

        it 'returns companies ordered by vacancies' do
          subject

          expect(json_data[0]['id']).to eq(company_3.id)
          expect(json_data[1]['id']).to eq(company_1.id)
          expect(json_data[2]['id']).to eq(company_2.id)
        end
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
    let(:user) { create(:user) }

    subject { put :update, params: company_params }

    context 'when user authenticated' do
      before { authenticate_user(user) }

      context 'when user has permissions' do
        let(:user) { company.owner }

        it_behaves_like 'a success request'
        it 'updates existing company' do
          subject

          expect(json_data).not_to be_empty
          expect(json_data['name']).to eq('N' * 10)
        end
      end

      context 'when user does not have permissions' do
        it { is_expected.to have_http_status(:forbidden) }
        it 'does not update the company' do
          subject

          expect(json_success_status).to be_falsy
          expect(json_errors).to be_present
          expect(json_errors).to include(/You don't have permissions do do this/)
        end
      end
    end

    context 'when user is not authenticated' do
      it_behaves_like 'an unauthenticated user'
    end
  end

  describe 'POST #create' do
    context 'when user have permissions' do
      subject { post :create, params: params }

      let(:user) { create(:user) }

      before { authenticate_user(user) }

      context 'with valid params' do
        let(:params) { attributes_for(:company, logo_data_uri: "data:image/png;base64,#{Base64.encode64(open('spec/support/test_files/valid_company_logo.png').to_a.join)}") }

        it { is_expected.to have_http_status(:created) }
        it 'creates company' do
          subject

          expect(json_success_status).to be_truthy
          expect(json_data).to be_present
          expect(Company.count).to eq(1)
        end
      end

      context 'with invalid params' do
        let(:params) { { name: 'A' } }

        it { is_expected.to have_http_status(:unprocessable_entity) }
        it 'does not create entity' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).to be_present
          expect(Company.count).to eq(0)
        end
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

    context 'when user authenticated' do
      let(:user) { create(:user) }

      before { authenticate_user(user) }

      context 'when user has permissions' do
        let(:user) { company.owner }

        it_behaves_like 'a success request'
        it 'deletes existing company' do
          subject

          expect(json_success_status).to be_truthy
          expect(Company.count).to eq(0)
        end
      end

      context 'when user does not have permissions' do
        it { is_expected.to have_http_status(:forbidden) }
        it 'does not delete the company' do
          subject

          expect(json_success_status).to be_falsy
          expect(json_errors).to be_present
          expect(json_errors).to include(/You don't have permissions do do this/)
        end
      end
    end

    context 'when user does not have permissions' do
      it_behaves_like 'an unauthenticated user'
    end
  end
end
