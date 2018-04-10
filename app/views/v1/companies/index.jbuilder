# frozen_string_literal: true

json.success true

json.data do
  json.companies do
    json.array!(@companies, partial: 'v1/companies/company', as: :company)
  end
  json.current_page @companies.current_page
  json.total_pages @companies.total_pages
end
