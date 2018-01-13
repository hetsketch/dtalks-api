# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a create action' do
  subject { post :create, params: params }

  context 'with valid params' do
    let(:params) { attributes_for(entity_class.downcase.to_sym) }

    it { is_expected.to have_http_status(:created) }
    it 'creates entity' do
      subject

      expect(json_success_status).to be_truthy
      expect(json_data).to be_present
      expect(eval("#{entity_class}.count")).to eq(1)
    end
  end

  context 'with invalid params' do
    let(:params) { invalid_params }

    it { is_expected.to have_http_status(:unprocessable_entity) }
    it 'does not create entity' do
      subject

      expect(json_success_status).to be_falsey
      expect(json_errors).to be_present
      expect(eval("#{entity_class}.count")).to eq(0)
    end
  end
end