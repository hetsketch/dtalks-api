# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :company, counter_cache: true
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :text, presence: true
end
