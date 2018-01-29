# frozen_string_literal: true
json.success true

json.data do
  json.partial! 'v1/companies/company', company: @company
end