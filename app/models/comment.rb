# frozen_string_literal: true

class Comment < ApplicationRecord
  # Scopes

  # Constants

  # Enums

  # Associations
  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  # Validations
  validates :text, :author, :commentable, presence: true
  validates :text, length: { maximum: 2000 }
  # Callbacks

  # Uploaders
end
