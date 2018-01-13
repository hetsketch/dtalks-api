# frozen_string_literal: true

class PhotoUploader < BaseUploader
  version :thumb do
    process resize_to_fill: [1024, 1024]
  end
end
