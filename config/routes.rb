DinnerDash::Application.routes.draw do
  
  resources :categories
  resources :items
  
  get  'about', to: 'marketing#about'
  get  'faqs',  to: 'marketing#faqs'

  root 'marketing#index'
  
end
