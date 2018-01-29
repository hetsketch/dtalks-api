# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'an unauthenticated user' do
  it 'returns authentication error' do
    subject

    expect(json_success_status).to be_falsey
    expect(json_errors).to be_present
    expect(json_errors).to include(/You need to sign in or sign up before continuing./)
  end
end
