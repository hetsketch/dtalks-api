# frozen_string_literal: true

class AvatarUploader < BaseUploader
  process :crop_image

  version :thumb do
    process resize_to_fill: [50, 50]
  end

  def crop_image
    if model.avatar_crop_x.present?
      manipulate! do |img|
        w = model.avatar_crop_w.to_i
        h = model.avatar_crop_h.to_i
        x = model.avatar_crop_x.to_i
        y = model.avatar_crop_y.to_i
        img.crop("#{w}x#{h}+#{x}+#{y}")
      end
    end
  end
end
