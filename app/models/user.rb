# frozen_string_literal: true

class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable,
         omniauth_providers: %i[github google_oauth2 vkontakte]
  include DeviseTokenAuth::Concerns::User
  include AvatarUploader::Attachment.new(:avatar)

  # Scopes

  # Constants

  # Enums

  # Associations
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :participants
  has_many :events, through: :participants, dependent: :destroy
  belongs_to :company, counter_cache: :employees_count, optional: true

  # Validations
  validates :email, length: { in: 5..100 }
  validates :username, presence: true, uniqueness: true, length: { in: 2..30 }
  validates :first_name, :last_name, :position, :city,
            length: { in: 2..100 }, allow_nil: true, allow_blank: true
  validates :bio, length: { in: 10..300 }, allow_nil: true, allow_blank: true
  validates :links, url: true
  # Fields
  attr_accessor :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h

  # Callbacks

  class << self
    def create_with_omniauth(auth)
      # first_or_create find first user in the table if it exists and return it
      # block will be executed only when create method is being invoked
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.provider = auth.provider
        case auth.provider
        when 'google_oauth2'
          with_google(user, auth)
        when 'vkontakte'
          with_vk(user, auth)
        when 'github'
          with_github(user, auth)
        end
      end
    end

    def with_google(user, auth)
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.username = user.first_name[0].upcase + user.last_name[0].upcase
    end

    def with_vk(user, auth)
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.username = if auth.extra.screen_name
                        auth.extra.screen_name
                      else
                        user.first_name[0].upcase + user.last_name[0].upcase
                      end
    end

    def with_github(user, auth)
      # user.username = auth.info.nickname
      user.first_name = auth.info.name
    end
  end

  def avatar?
    avatar.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
