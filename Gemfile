# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.1.2'

group :development, :test do
  gem 'awesome_print', '~> 1.8.0', require: 'ap'
  gem 'bullet'
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'listen', '~> 3.0.5'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails_dt'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'rubocop', '~> 0.49.1', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'fuubar'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
  gem 'shrine-memory'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'aws-sdk-s3', '~> 1.2'
gem 'devise_token_auth'
gem 'email_validator'
gem 'fastimage'
gem 'image_processing'
gem 'mini_magick', '>= 4.3.5'
gem 'pg'
gem 'shrine'

# OAuth providers
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-vkontakte'

gem 'acts-as-taggable-on'
gem 'dotenv-rails', groups: %i[development test production]
gem 'impressionist'
gem 'jbuilder'
gem 'kaminari'
gem 'pundit'
gem 'rack-cors'
gem 'rails-i18n', '~> 5.0.0'
gem 'rolify'
