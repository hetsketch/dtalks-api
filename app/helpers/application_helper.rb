# frozen_string_literal: true

module ApplicationHelper
  def avatar_url(user, size: :original)
    if user.avatar.present?
      user.avatar[size].url
    else
      GravatarService.new(user).fetch_avatar_url(size)
    end
  end
end
