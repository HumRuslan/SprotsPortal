Rails.application.routes.draw do
  devise_scope :user do
    root "auth/sessions#new"
  end

  devise_for :users, controllers: {
    registrations: 'auth/registrations',
    sessions: 'auth/sessions'
  }

  namespace :account do
    namespace :admin do
      root "user#users"
      get "/users/", to: 'user#users'
      put "/blocked/", to: 'user#blocked'
      put "/activated/", to: 'user#activated'
    end
  end
end
