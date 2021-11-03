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
          put "add-admin"
          put "remove-admin"
        end
        collection do
          match 'search' => 'user#search', via: %i[get post], as: :search
        end
      end
    end
  end
end
