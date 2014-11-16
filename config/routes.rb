Rails.application.routes.draw do
  resources :orders do
    get :new_csv
    post :import_csv
  end

  root to: 'orders#index'
end
