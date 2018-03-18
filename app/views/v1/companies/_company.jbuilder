# frozen_string_literal: true

json.extract!(company, :id, :name, :city, :info, :url, :employees_count, :vacancies_count, :reviews_count)
if company.logo.present?
  json.logo company.logo[:original].url
  json.thumb company.logo[:thumbnail].url
end
json.photos company.photos do |photo|
  json.url photo.image[:original].url
end