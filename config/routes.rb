Rails.application.routes.draw do
  root 'weather#index'
  get '/search', to: 'weather#search'
  post '/search', to: 'weather#search'
  get '/history', to: 'weather#history'
  delete '/history/:id', to: 'weather#destroy', as: :delete_weather_data
end
