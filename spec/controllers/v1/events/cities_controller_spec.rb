# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Events::CitiesController, type: :controller do
  describe 'GET #index' do
    let!(:events) { create_list(:event, 4) }

    subject { get :index }

    it_behaves_like 'a success request'
    it 'returns all cities' do
      subject

      expect(json_data.length).to eql(4)
    end
  end
end
