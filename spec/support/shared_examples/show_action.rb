# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a show action' do
  subject { get :show, params: params }

  context 'when entity exists' do
    let(:params) { { id: entity.id } }

    it { is_expected.to have_http_status(:ok) }
    it 'returns entity by id' do
      subject

      expect(json_success_status).to be_truthy
      expect(json_data).not_to be_empty
      expect(json_data['id']).to eq(entity.id)
    end
  end

  context 'when entity does not exist' do
    let(:params) { { id: 100_000 } }

    it { is_expected.to have_http_status :not_found }
    it 'returns an error' do
      subject

      expect(json_success_status).to be_falsy
      expect(json_errors).to be_present
    end
  end
end
