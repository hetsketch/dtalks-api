# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a success request' do
  it 'has success status' do
    subject

    expect(response).to have_http_status(:ok)
    expect(json_success_status).to be_truthy
  end
end
