Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_scope :user do
    root "auth/sessions#new"
  end

  devise_for :users, controllers: {
    registrations: 'auth/registrations',
    sessions: 'auth/sessions'
  }

  namespace :account do
    namespace :admin do
      root "home#index"
      resources :user, only: %i[index destroy] do
        member do
          put "blocked"
          put "activated"
          put "add-admin"
          put "remove-admin"
        end
      end
      resources :article
    end
  end
end
