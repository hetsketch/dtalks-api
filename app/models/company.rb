# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :employees

  validates :name, :city, :info, :owner, presence: true
  validates :name, uniqueness: true, length: { in: 2..50 }
  validates :city, length: { in: 2..50 }
  validates :info, length: { maximum: 2000 }
end
