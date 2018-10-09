class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  validates :text, presence: true
end
