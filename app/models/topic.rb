# frozen_string_literal: true

class Topic < ApplicationRecord
  # Scopes
  scope :recently_added, -> { order(created_at: :desc) }

  # Constants

  # Enums

  # Associations
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many   :comments, as: :commentable, dependent: :destroy

  # Validations
  validates :title, :text, :author, presence: true
  validates :title, length: { in: 10..500 }, uniqueness: true
  validates :text,  length: { in: 100..30_000 }, uniqueness: true

  # Callbacks

  # Uploaders

  # add comments
  # add comments counter
  is_impressionable(counter_cache: true)
end
