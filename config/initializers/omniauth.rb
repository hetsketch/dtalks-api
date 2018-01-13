Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,        ENV['GITHUB_APP_ID'], ENV['GITHUB_APP_SECRET'], scope: 'user'
  provider :vkontakte,     ENV['VK_APP_ID'],     ENV['VK_APP_SECRET']
  provider :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET']
end