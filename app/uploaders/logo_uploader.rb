# frozen_string_literal: true
require 'image_processing/mini_magick'

class LogoUploader < Shrine
  include ImageProcessing::MiniMagick

  LOGO_MAX_SIZE = 300
  THUMBNAIL_SIZE = 96

  plugin :processing
  plugin :versions
  plugin :validation_helpers
  plugin :data_uri
  plugin :store_dimensions

  Attacher.validate do
    validate_max_size 100 * 1024, message: "is too large (max is 100 Kb)"
    validate_max_height LOGO_MAX_SIZE
    validate_max_width LOGO_MAX_SIZE
  end

  process :store do |io, context|
    thumbnail = resize_to_limit(io, THUMBNAIL_SIZE, THUMBNAIL_SIZE)

    { original: io, thumbnail: thumbnail }
  end
end