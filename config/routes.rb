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
      root "user#index"
      resources :user do
        member do
          put "blocked"
          put "activated"
        end
      end
    end
  end
end
