# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Topics::CommentsController, type: :controller do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:params) { attributes_for(:comment).reverse_merge(topic_id: topic.id) }

    subject { post :create, params: params }

    context 'when user authenticate' do
      before { authenticate_user(user) }

      it { is_expected.to have_http_status(:created) }
      it 'creates comment' do
        subject

        expect(json_success_status).to be_truthy
        expect(json_data).not_to be_empty
        expect(topic.comments.count).to eql(1)
        expect(topic.comments.first.author).to eql(user)
      end

      context 'when add comment to nonexistent topic' do
        let(:params) { attributes_for(:comment).reverse_merge(topic_id: 18_243) }

        it { is_expected.to have_http_status(:not_found) }
        it 'does not create a comment' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).not_to be_empty
          expect(Comment.count).to be_eql(0)
        end
      end
    end

    context 'when user does not authenticate' do
      it { is_expected.to have_http_status(:unauthorized) }
      it 'does not create a comment' do
        subject

        expect(json_success_status).to be_falsey
        expect(json_errors).not_to be_empty
        expect(Comment.count).to be_eql(0)
      end
    end
  end

  describe 'PUT #update' do
    let!(:comment) { create(:comment, commentable: topic) }
    let(:params) { { id: comment.id, topic_id: topic.id, text: 'new text' } }

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
        expect(json_data['text']).to be_eql('new text')
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
    let!(:comment) { create(:comment, commentable: topic) }
    let(:params) { { id: comment.id, topic_id: topic.id } }

    subject { delete :destroy, params: params }

    context 'when user authenticate' do
      before { authenticate_user(user) }

      context 'when comment exists' do
        # TODO: only author or admin is able to remove comment
        it { is_expected.to have_http_status(:ok) }
        it 'deletes comment' do
          subject

          expect(json_success_status).to be_truthy
          expect(topic.comments.count).to be_eql(0)
        end
      end

      context 'when comment does not exist' do
        let(:params) { { id: 18_650, topic_id: topic.id } }

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
end
