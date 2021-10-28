Rails.application.routes.draw do
  root "user#index"
  devise_for :users, controllers: { registrations: 'auth/registrations' }
end
