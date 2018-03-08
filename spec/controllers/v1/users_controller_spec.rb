# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe 'GET #show' do
    it_behaves_like 'a show action' do
      let(:entity) { create(:user) }
    end
  end
end
