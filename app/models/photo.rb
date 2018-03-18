# frozen_string_literal: true

class Photo < ApplicationRecord
  include CompanyPhotosUploader::Attachment.new(:image)

  belongs_to :company
end
