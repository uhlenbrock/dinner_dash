DinnerDash::Application.routes.draw do
  
  resources :sessions
  resources :orders
  resources :users
  resources :categories
  resources :items
  resources :menu, only: [:index]
  
  get 'cart',                 to: 'cart#show',   as: :cart
  get 'cart/:item_id/add',    to: 'cart#add',    as: :add_item_cart
  get 'cart/:item_id/remove', to: 'cart#remove', as: :remove_item_cart
  
  get 'signup',  to: 'users#new'
  get 'signin',  to: 'sessions#new'
  get 'signout', to: 'sessions#destroy'
  
  get 'about',   to: 'marketing#about'
  get 'faqs',    to: 'marketing#faqs'
  
  root 'marketing#index'
  
end
