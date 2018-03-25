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
        expect(topic.reload.comments_count).to eql(1)
      end

      context 'when add comment to nonexistent topic' do
        let(:params) { attributes_for(:comment).reverse_merge(topic_id: 18_243) }

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
    let!(:comment) { create(:comment, commentable: topic) }
    let(:params) { { id: comment.id, topic_id: topic.id, text: 'new text' } }

    subject { put :update, params: params }

    context 'when user authenticated' do
      before { authenticate_user(user) }

      context 'when user has permissions' do
        let(:user) { comment.author }

        it { is_expected.to have_http_status(:ok) }
        it 'updates comment' do
          subject

          expect(json_success_status).to be_truthy
          expect(json_data['text']).to eql('new text')
        end
      end

      context 'when user does not have permissions' do
        it { is_expected.to have_http_status(:forbidden) }
        it 'does not update comment' do
          subject

          expect(json_success_status).to be_falsey
          expect(json_errors).not_to be_empty
          expect(json_errors).to include(/You don't have permissions do do this/)
        end
      end
    end

    context 'when user does not authenticate' do
      it { is_expected.to have_http_status(:unauthorized) }
      it 'does not update comment' do
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

    context 'when user authenticated' do
      before { authenticate_user(user) }

      context 'when user has permissions' do
        let(:user) { comment.author }

        context 'when comment exists' do
          it { is_expected.to have_http_status(:ok) }
          it 'deletes comment' do
            subject

            expect(json_success_status).to be_truthy
            expect(topic.comments.count).to eql(0)
            expect(topic.reload.comments_count).to eql(0)
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

      context 'when user does not have permissions' do
        it { is_expected.to have_http_status(:forbidden) }
        it 'does not delete the comment' do
          subject

          expect(json_success_status).to be_falsy
          expect(json_errors).to_not be_empty
          expect(json_errors).to include(/You don't have permissions do do this/)
        end
      end
    end

    context 'when user does not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
      it 'does not delete a comment' do
        subject

        expect(json_success_status).to be_falsey
        expect(json_errors).not_to be_empty
      end
    end
  end

  describe 'GET #index' do
    let(:params) { { topic_id: topic.id } }

    subject { get :index, params: params }

    context 'when topic has comments' do
      let!(:topic_comments) { create_list(:comment, 3, commentable: topic) }
      let!(:other_comments) { create_list(:comment, 2) }

      it_behaves_like 'a success request'
      it 'returns only given topic comments' do
        subject

        expect(json_data).not_to be_empty
        expect(json_data['comments'].length).to eql(3)
      end
    end

    context 'when topic has not comments' do
      it_behaves_like 'a success request'
      it 'returns empty array' do
        subject

        expect(json_data).not_to be_empty
        expect(json_data['comments'].length).to eql(0)
      end
    end
  end
end
