Rails.application.routes.draw do
  
  
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  
  post '/signup', to: 'users#create'
  get '/signup', to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  patch 'users/:id/edit', to: 'users#update'
  
  resources :users
  resources :account_activation, only: [:edit]
end
