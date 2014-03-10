DinnerDash::Application.routes.draw do
  
  resources :sessions
  resources :orders
  resources :users
  resources :categories
  resources :items
  resources :menu, only: [:index]
  
  get 'signup',  to: 'users#new'
  get 'signin',  to: 'sessions#new'
  get 'signout', to: 'sessions#destroy'
  
  get 'about',   to: 'marketing#about'
  get 'faqs',    to: 'marketing#faqs'
  
  root 'marketing#index'
  
end
