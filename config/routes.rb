Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1, default: { format: :json } do
    resources :sessions, only: %i[create destroy show]
    resources :users, only: %i[create]
    resources :collections, only: [:create]
    resources :uploads, only: [:create]
    get '/users/:username/:token', to: 'users#user_info'
    post '/users/account', to: 'users#account_info'
    post '/users/account/update_ava', to: 'users#update_ava'
    post '/users/account/update', to: 'users#update_account'
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
    get 'items/search/:query', to: 'items#search'
    post '/users/follow/:id/:username', to: 'users#follow'
    post 'items/download/:item_id', to: 'items#download'
  end
end
