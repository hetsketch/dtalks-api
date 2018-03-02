# frozen_string_literal: true

class AvatarUploader < Shrine
  plugin :validation_helpers
  plugin :data_uri
  plugin :store_dimensions

  Attacher.validate do
    validate_max_size 100 * 1024, message: "is too large (max is 100 Kb)"
    validate_max_height 400
    validate_max_width 400
  end
end
