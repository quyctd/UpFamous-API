Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1, default: { format: :json } do
    resources :sessions, only: %i[create destroy show]
    resources :users, only: %i[create]
    resources :collections, only: [:create]
    resources :uploads, only: [:create]
    get '/users/:username', to: 'users#user_info'
    get 'items/homepage', to: 'items#homepage_thumbnail'
    get 'items/all', to: 'items#endless_item'
    get 'join_photo', to: 'users#join_photo'
    get 'items/show/:item_id', to: 'items#show'
    post 'items/following', to: 'items#following'
    post 'items/like', to: 'items#like'
    get 'collections', to: 'collections#all'
    get 'collections/:id', to: 'collections#show'
    post 'collections/add', to: 'collections#add'
    post 'collections/remove', to: 'collections#remove'
    post 'collections/user', to: 'collections#user'
  end
end
