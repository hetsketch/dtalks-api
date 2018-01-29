# frozen_string_literal: true

json.success true

json.data do
  json.array!(@companies, partial: 'v1/companies/company', as: :company)
end
