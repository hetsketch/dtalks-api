# frozen_string_literal: true

class UrlValidator < ActiveModel::EachValidator
  URL_REGEX = %r((https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9]\.[^\s]{2,}))

  def validate_each(record, attribute, value)
    if value.is_a?(Array)
      record.errors.add(attribute, 'must start with http:// or https://') if value.any? { |e| !e.match?(URL_REGEX) }
    else
      record.errors.add(attribute, 'must start with http:// or https://') unless value.match?(URL_REGEX)
    end
  end
end