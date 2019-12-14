Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1, default: { format: :json } do
    resources :sessions, only: %i[create destroy show]
    resources :users, only: [:create]
    resources :collections
    resources :uploads, only: [:create]
    get '/users/:username', to: 'users#user_info'
    get 'items/homepage', to: 'items#homepage_thumbnail'
    get 'items/all', to: 'items#endless_item'
    get 'users/join_photo', to: 'users#join_photo'
  end
end
