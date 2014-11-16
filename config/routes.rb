Rails.application.routes.draw do
  resources :orders

  root to: 'visitors#index'
end
