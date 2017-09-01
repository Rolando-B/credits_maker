Rails.application.routes.draw do
  root "static_pages#home"
  get 'static_pages/home'

  get 'static_pages/help'

  get '/about', to: "static_pages#about"

  get '/signup', to: "users#new"

  resources :users

  post '/signup',  to: 'users#create'
end
