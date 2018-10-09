Rails.application.routes.draw do
  # devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'auth', :controllers => { omniauth_callbacks: 'v1/users/omniauth_callbacks', sessions: 'v1/users/sessions' }

    resources :users, only: [:update, :show]

    resources :topics do
      resources :comments, module: 'topics'
    end

    resources :events do
      collection do
        resources :cities, only: [:index], module: 'events'
      end
      resources :comments, module: 'events'
    end

    resources :companies do
      resources :employees
    end

    resources :tags, only: [:index]

    root to: 'welcome#index'
  end

  mount ActionCable.server => '/cable'
end
