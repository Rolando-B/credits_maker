Rails.application.routes.draw do
  get 'streamers/new'

  get 'sessions/new'

  root "static_pages#home"
  get 'static_pages/home'

  get 'static_pages/help'

  get '/about', to: "static_pages#about"

  get '/signup', to: "users#new"

  resources :users

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  post '/signup',  to: 'users#create'

  resources :streamers

  get '/credits', to: 'streamers#credits'
  post '/credits', to: 'streamers#createJson'
  put '/credits/:id', to: 'streamers#updateJson'
  delete 'credits/:id', to: 'streamers#destroyJson'
end
