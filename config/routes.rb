Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1, default: { format: :json } do
    resources :sessions, only: [:create, :destroy, :show]
    resources :users, only: [:create]
    resources :collections
    resources :photos
    resources :uploads, only: [:create]
  end
end
