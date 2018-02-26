# frozen_string_literal: true

class Event < ApplicationRecord
  # Scopes
  scope :past, -> { where('end_time < ?', Time.now) }
  scope :upcoming, -> { where('start_time > ?', Time.now).order(start_time: :asc) }
  scope :city_events, -> (cities) { where(city: cities) }
  # Constants

  # Enums

  # Associations
  has_many :participants
  has_many :users, through: :participants
  # TODO: add comments to events
  # has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  # Validations
  validates :title, :text, :author, :start_time, :end_time, :city, presence: true
  validates :price, presence: true, unless: :free?
  validates :address, presence: true, unless: :online?
  validates :title, length: { in: 5..100 }, uniqueness: true
  validates :text, length: { in: 100..10_000 }
  validates_inclusion_of :free, in: [true, false]
  validates_inclusion_of :online, in: [true, false]

  # Callbacks

  # Uploaders
  # TODO: add images to events
  # mount_uploader :photo, PhotoUploader

  is_impressionable(counter_cache: true)

  def self.group_by_day(relation)
    relation.group_by { |e| e.start_time.strftime('%Y-%m-%d') }
  end
end
