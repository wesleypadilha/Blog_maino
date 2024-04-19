# config/routes.rb

Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    resources :comments, only: [:create]
  end

  get '/login', to: 'login#new'
  post '/login', to: 'login#create'
  delete '/logout', to: 'login#destroy'

  get '/register', to: 'register#new'
  post '/register', to: 'register#create'

  get '/forgot_password', to: 'password_resets#new'
  post '/forgot_password', to: 'password_resets#create'
  get '/reset_password/:token', to: 'password_resets#edit', as: 'reset_password'
  patch '/reset_password/:token', to: 'password_resets#update'
end
