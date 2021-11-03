Rails.application.routes.draw do
  devise_scope :user do
    root "auth/sessions#new"
  end

  devise_for :users, controllers: {
    registrations: 'auth/registrations',
    sessions: 'auth/sessions'
  }

  mount Ckeditor::Engine => '/ckeditor'

  namespace :account do
    namespace :admin do
      root "home#index"
      resources :user do
        member do
          put "blocked"
          put "activated"
          put "add-admin"
          put "remove-admin"
        end
      end
    end
  end
end
