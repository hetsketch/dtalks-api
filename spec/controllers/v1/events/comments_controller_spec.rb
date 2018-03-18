# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Events::CommentsController, type: :controller do
  let(:event) { create(:event) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:params) { attributes_for(:comment).reverse_merge(event_id: event.id) }

    subject { post :create, params: params }

    context 'when user authenticate' do
      before { authenticate_user(user) }

      it { is_expected.to have_http_status(:created) }
      it 'creates comment' do
        subject

        expect(json_success_status).to be_truthy
        expect(json_data).not_to be_empty
        expect(event.comments.count).to eql(1)
        expect(event.comments.first.author).to eql(user)
        expect(event.reload.comments_count).to eql(1)
      end

      context 'when add comment to nonexistent event' do
        let(:params) { attributes_for(:comment).reverse_merge(event_id: 18_243) }

        it { is_expected.to have_http_status(:not_found) }
        it 'does not create a comment' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).not_to be_empty
          expect(Comment.count).to eql(0)
        end
      end
    end

    context 'when user does not authenticate' do
      it { is_expected.to have_http_status(:unauthorized) }
      it 'does not create a comment' do
        subject

        expect(json_success_status).to be_falsey
        expect(json_errors).not_to be_empty
        expect(Comment.count).to eql(0)
      end
    end
  end

  describe 'PUT #update' do
    let!(:comment) { create(:comment, commentable: event) }
    let(:params) { { id: comment.id, event_id: event.id, text: 'new text' } }

    subject { put :update, params: params }

    context 'when user authenticate' do
      before do
        authenticate_user(user)
      end

      # TODO: only author or admin is able to modify comment
      it { is_expected.to have_http_status(:ok) }
      it 'updates comment' do
        subject

        expect(json_success_status).to be_truthy
        expect(json_data['text']).to eql('new text')
      end
    end

    context 'when user does not authenticate' do
      it { is_expected.to have_http_status(:unauthorized) }
      it 'does not create a comment' do
        subject

        expect(json_success_status).to be_falsey
        expect(json_errors).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, commentable: event) }
    let(:params) { { id: comment.id, event_id: event.id } }

    subject { delete :destroy, params: params }

    context 'when user authenticate' do
      before { authenticate_user(user) }

      context 'when comment exists' do
        # TODO: only author or admin is able to remove comment
        it { is_expected.to have_http_status(:ok) }
        it 'deletes comment' do
          subject

          expect(json_success_status).to be_truthy
          expect(event.comments.count).to eql(0)
          expect(event.reload.comments_count).to eql(0)
        end
      end

      context 'when comment does not exist' do
        let(:params) { { id: 18_650, event_id: event.id } }

        it { is_expected.to have_http_status(:not_found) }
        it 'does not delete comment' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).to_not be_empty
        end
      end
    end

    context 'when user does not authenticate' do
      it { is_expected.to have_http_status(:unauthorized) }
      it 'does not delete a comment' do
        subject

        expect(json_success_status).to be_falsey
        expect(json_errors).not_to be_empty
      end
    end
  end

  describe 'GET #index' do
    let(:params) { { event_id: event.id } }

    subject { get :index, params: params }

    context 'when event has comments' do
      let!(:event_comments) { create_list(:comment, 3, commentable: event) }
      let!(:other_comments) { create_list(:comment, 2) }

      it_behaves_like 'a success request'
      it 'returns only given event comments' do
        subject

        expect(json_data).not_to be_empty
        expect(json_data['comments'].length).to eql(3)
      end
    end

    context 'when event has not comments' do
      it_behaves_like 'a success request'
      it 'returns empty array' do
        subject

        expect(json_data).not_to be_empty
        expect(json_data['comments'].length).to eql(0)
      end
    end
  end
end
