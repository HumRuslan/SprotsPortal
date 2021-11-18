Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_scope :user do
    root "account/user/home#index"
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
      resources :article do
        member do
          put "published"
          put "unpublished"
        end
      end
      resources :category, only: %i[index new create edit update destroy] do
        resources :sub_category, only: %i[new create edit update destroy] do
          resources :team, only: %i[new create edit update destroy]
        end
      end
    end

    namespace :user do
      root "home#index"
      resources :article, controller: :home, only: %i[index show]
      resources :user, controller: :profile, only: %i[edit update]
    end
  end
end
