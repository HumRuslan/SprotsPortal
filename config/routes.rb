Rails.application.routes.draw do
  devise_scope :user do
    root "devise/sessions#new"
  end

  devise_for :users, controllers: { registrations: 'auth/registrations' }

  namespace :account do
    namespace :admin do
      root "user#index"
    end
  end
end
