# frozen_string_literal: true

class Company < ApplicationRecord
  include LogoUploader::Attachment.new(:logo)

  # To prevent sql injection
  ORDER_MAPPINGS = {
    'rating' => 'rating DESC',
    'employees' => 'employees_count DESC',
    'vacancies' => 'vacancies_count DESC',
  }

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :employees, class_name: 'User'
  has_many :vacancies, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos

  validates :name, :city, :info, :owner, :logo, :rating, presence: true
  validates :name, uniqueness: true, length: { in: 2..50 }
  validates :city, length: { in: 2..50 }
  validates :info, length: { maximum: 3000 }

  def self.order_by(value)
    return order(ORDER_MAPPINGS['employees']) if value.blank? || !ORDER_MAPPINGS.key?(value)
    order(ORDER_MAPPINGS[value])
  end

  def self.search(query)
    return all if query.blank?
    where('LOWER (name) LIKE LOWER(?)', "%#{query}%")
  end
end
