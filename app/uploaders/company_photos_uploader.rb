# frozen_string_literal: true

require 'image_processing/mini_magick'

class CompanyPhotosUploader < Shrine
  include ImageProcessing::MiniMagick

  THUMBNAIL_SIZE = 96

  plugin :processing
  plugin :versions
  plugin :validation_helpers
  plugin :data_uri
  plugin :store_dimensions

  Attacher.validate do
    validate_max_size 1000 * 1024, message: "is too large (max is 1 Mb)"
  end

  process :store do |io, context|
    thumbnail = resize_to_limit(io, THUMBNAIL_SIZE, THUMBNAIL_SIZE)

    { original: io, thumbnail: thumbnail }
  end
end