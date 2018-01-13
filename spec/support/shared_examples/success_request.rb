# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a success request' do
  it { is_expected.to have_http_status(:ok) }
end
