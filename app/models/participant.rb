# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: :participants_count
end
