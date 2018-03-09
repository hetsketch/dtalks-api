# frozen_string_literal: true

class UrlValidator < ActiveModel::EachValidator
  URL_REGEX = /\A(https?:\/\/){1}([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/

  #TODO: add i18n message instead hardcoded
  def validate_each(record, attribute, value)
    if value.is_a?(Array)
      record.errors.add(attribute, 'must start with http:// or https://') if value.any? { |e| !e.match?(URL_REGEX) }
    else
      record.errors.add(attribute, 'must start with http:// or https://') unless value.match?(URL_REGEX)
    end
  end
end
