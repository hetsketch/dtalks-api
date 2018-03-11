# frozen_string_literal: true

json.extract!(company, :id, :name, :city, :info)
json.logo company.logo[:original].data_uri
json.thumb company.logo[:thumbnail].data_uri
