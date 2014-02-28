DinnerDash::Application.routes.draw do
  
  resources :categories
  resources :items

  root 'application#index'
  
end
