# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::EventsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    context 'when events exist' do
      let!(:passed_events) { create_list(:event, 3, :passed) }
      let!(:future_events) { create_list(:event, 2, :future) }

      it_behaves_like 'a success request'
      it 'returns only future events' do
        subject

        expect(json_data.length).to eq(2)
        expect(json_data[0]['title']).to eq(future_events[0].title)
        expect(json_data[1]['title']).to eq(future_events[1].title)
      end
    end

    context 'when there are no events' do
      it_behaves_like 'a success request'
      it 'returns empty `data` object' do
        subject

        expect(json_success_status).to be_truthy
        expect(json_data).to be_empty
      end
    end
  end

  describe 'GET #show' do
    it_behaves_like 'a show action' do
      let(:entity) { create(:event) }
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'when user have permissions' do
      let(:user) { create(:user) }

      before { authenticate_user(user) }

      it_behaves_like 'a create action' do
        let(:entity_class) { 'Event' }
        let(:invalid_params) { { title: 'short' } }
      end
    end

    context 'when user does not have permissions' do
      let(:params) { attributes_for(:event) }

      it_behaves_like 'an unauthenticated user'
    end
  end

  describe 'PUT #update' do
    let(:author) { create(:user) }
    let!(:event) { create(:event, author: author) }

    subject { put :update, params: params }

    context 'when user authenticated' do
      before { authenticate_user(author) }

      context 'with valid params' do
        let(:params) { { id: event.id, title: 'new title' } }

        it_behaves_like 'a success request'
        it 'updates event' do
          subject

          expect(json_success_status).to be_truthy
          expect(json_data).to be_present
          expect(json_data['title']).to eql('new title')
        end
      end

      context 'with invalid params' do
        let(:params) { { id: event.id, text: '' } }

        it { is_expected.to have_http_status(:unprocessable_entity) }
        it 'returns validation errors' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).to be_present
          expect(Event.find(event.id).text).to_not eq('')
        end
      end
    end

    context 'when user does not authenticated' do
      let(:params) { { id: event.id, title: 'new title' } }

      it_behaves_like 'an unauthenticated user'
    end
  end

  describe 'DELETE #destroy' do
    let(:author) { create(:user) }
    let!(:event) { create(:event, author: author) }

    subject { delete :destroy, params: params }

    context 'when user authenticated' do
      let(:params) { { id: event.id } }

      before { authenticate_user(author) }

      context 'when event exists' do
        it_behaves_like 'a success request'
        it 'deletes event' do
          subject

          expect(json_success_status).to be_truthy
          expect(json_data).to be_nil
          expect(json_errors).to be_nil
        end
      end

      context 'when event does not exist' do
        let(:params) { { id: 10_000 } }

        it { is_expected.to have_http_status(:not_found) }
        it 'does not delete the event' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).to be_present
          expect(json_errors).to include("Couldn't find Event")
        end
      end
    end

    context 'when user does not authenticated' do
      let(:params) { { id: event.id } }

      it_behaves_like 'an unauthenticated user'
    end
  end
end
