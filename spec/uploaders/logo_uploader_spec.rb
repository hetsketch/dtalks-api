# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LogoUploader do
  let(:company) { create(:company) }

  it 'generates thumbnails' do
    expect(company.logo.keys).to eq([:original, :thumbnail])
  end
end