# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::TopicsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    context 'when topics exist' do
      let!(:topic1) { create(:topic, created_at: DateTime.now + 1) }
      let!(:topic2) { create(:topic, created_at: DateTime.now + 2) }
      let!(:topic3) { create(:topic, created_at: DateTime.now + 3) }

      it { is_expected.to have_http_status(:ok) }
      it 'returns topics in desc order' do
        subject

        expect(json_success_status).to be_truthy
        expect(json_data[0]['id']).to eq(topic3.id)
        expect(json_data[1]['id']).to eq(topic2.id)
        expect(json_data[2]['id']).to eq(topic1.id)
      end
    end

    context 'when topics do not exist' do
      it { is_expected.to have_http_status(:ok) }
      it 'returns empty `data` array' do
        subject

        expect(json_success_status).to be_truthy
        expect(json_data).to be_empty
      end
    end
  end

  describe 'GET #show' do
    subject { get :show, params: params }

    it_behaves_like 'a show action' do
      let(:entity) { create(:topic) }
    end
  end

  describe 'POST #create' do
    subject { post :create, params: topic_params }

    context 'when user have permissions' do
      let(:topic_params) { attributes_for(:topic) }
      let(:user) { create(:user) }

      before { authenticate_user(user) }

      it { is_expected.to have_http_status(:created) }
      it 'creates new topic' do
        subject

        expect(json_success_status).to be_truthy
        expect(json_data).not_to be_empty
        expect(Topic.count).to eq(1)
      end

      context 'when topic params invalid' do
        let(:topic_params) { attributes_for(:topic, title: '') }

        it 'returns an error' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).to be_present
        end
      end
    end

    context 'when user does not have permissions' do
      let(:topic_params) { attributes_for(:topic) }

      it 'return authentication error' do
        subject

        expect(json_success_status).to be_falsey
        expect(json_errors).to be_present
        expect(json_errors).to include(/You need to sign in or sign up before continuing./)
      end
    end
  end

  describe 'PUT #update' do
    let!(:topic) { create(:topic) }
    let(:topic_params) { { id: topic.id, title: 'N' * 10 } }

    subject { put :update, params: topic_params }

    context 'when user authenticated' do
      let(:user) { create(:user) }

      before { authenticate_user(user) }

      context 'when user have permissions' do
        let(:user) { topic.author }

        it { is_expected.to have_http_status(:ok) }
        it 'updates existing topic' do
          subject

          expect(json_success_status).to be_truthy
          expect(json_data).not_to be_empty
          expect(json_data['title']).to eq('N' * 10)
        end
      end

      context 'when user does not have permissions' do
        it { is_expected.to have_http_status(:forbidden) }
        it 'does not update existing topic' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).to be_present
          expect(json_errors).to include(/You don't have permissions do do this/)
        end
      end
    end

    context 'when user does not authenticated' do
      it 'return authentication error' do
        subject

        expect(json_success_status).to be_falsey
        expect(json_errors).to be_present
        expect(json_errors).to include(/You need to sign in or sign up before continuing./)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:topic) { create(:topic) }
    let(:topic_params) { { id: topic.id } }

    subject { delete :destroy, params: topic_params }

    context 'when user authenticated' do
      let(:user) { create(:user) }

      before { authenticate_user(user) }

      context 'when user have permissions' do
        let(:user) { topic.author }

        it { is_expected.to have_http_status(:ok) }
        it 'deletes existing topic' do
          subject

          expect(json_success_status).to be_truthy
          expect(Topic.count).to eq(0)
        end
      end

      context 'when user does not have permissions' do
        it { is_expected.to have_http_status(:forbidden) }
        it 'does not delete existing topic' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).to be_present
          expect(json_errors).to include(/You don't have permissions do do this./)
        end
      end
    end

    context 'when user does not authenticated' do
      it 'return authentication error' do
        subject

        expect(json_success_status).to be_falsey
        expect(json_errors).to be_present
        expect(json_errors).to include(/You need to sign in or sign up before continuing./)
      end
    end
  end
end
