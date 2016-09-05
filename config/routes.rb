Rails.application.routes.draw do
  root 'contests#index'
  
  resources :contests

  resources :videos
  
  devise_for :users

  resources :users

  get '/contest/:contest_id/videos', to: 'videos#index'
  get '/contest/:contest_id/videos/new', to: 'videos#new'
  post '/contest/:contest_id/videos/save', to: 'videos#create'
  get '/contest/:contest_id/videos/show/:id', to: 'videos#show'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
