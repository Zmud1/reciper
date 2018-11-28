Rails.application.routes.draw do
  
  get '/signup', to: 'users#new'

  root 'static_pages#home'
  
  get '/about', to: 'static_pages#about'
  
  get '/help', to: 'static_pages#help'
  
  get '/contact', to: 'static_pages#contact'
  
  post '/signup', to: 'users#create'
  resources :users

end
