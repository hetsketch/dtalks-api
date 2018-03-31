# frozen_string_literal: true

class GravatarService
  BASE_URI = 'http://gravatar.com/avatar/'
  SIZES = { original: '400', thumbnail: '64' }

  def initialize(user)
    @user = user
  end

  def fetch_avatar_url(size, default: 'identicon')
    "#{BASE_URI}#{user_hash}?s=#{SIZES[size]}&d=#{default}"
  end

  private

  def user_hash
    Digest::MD5::hexdigest(@user.email).downcase
  end
end