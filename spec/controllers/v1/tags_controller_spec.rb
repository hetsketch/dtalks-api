# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::TagsController, type: :controller do
  describe 'GET #index' do
    before do
      create(:tag, name: 'business')
      create(:tag, name: 'computer science')
      create(:tag, name: 'ai')
      create(:tag, name: 'ruby')
    end

    subject { get :index, params: params }

    context 'when params are empty' do
      let(:params) { {} }

      it_behaves_like 'a success request'
      it 'returns all tags' do
        subject

        expect(json_data['tags'].length).to eql(4)
        expect(json_data['tags'].include?('business')).to be_truthy
        expect(json_data['tags'].include?('computer science')).to be_truthy
        expect(json_data['tags'].include?('ai')).to be_truthy
        expect(json_data['tags'].include?('ruby')).to be_truthy
      end
    end

    context 'when params present' do
      let(:params) { { s: 's' } }

      it 'returns tags which include `s`' do
        subject

        expect(json_data['tags'].length).to eql(2)
        expect(json_data['tags'].include?('business')).to be_truthy
        expect(json_data['tags'].include?('computer science')).to be_truthy
      end
    end
  end
end
