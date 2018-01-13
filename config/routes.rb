Rails.application.routes.draw do
  # devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'auth', :controllers => { omniauth_callbacks: 'v1/users/omniauth_callbacks' }

    # resources :users

    resources :topics do
      resources :comments, module: 'topics'
    end

    resources :events do
      resources :comments, module: 'v1/events'
    end

    resources :companies do
      resources :employees
    end

    root to: 'welcome#index'
  end
end
