Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { registrations: 'auth/registrations' }

  namespace :account do
    namespace :admin do
      root "user#index"
    end
  end
end
