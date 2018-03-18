# frozen_string_literal: true

class Vacancy < ApplicationRecord
  validates :name, presence: true

  belongs_to :company, counter_cache: true
end
