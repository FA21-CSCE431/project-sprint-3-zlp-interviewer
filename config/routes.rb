Rails.application.routes.draw do
  root 'users#index'
    
  resources :admins do
    member do 
      get :get_dates
    end
    collection do
      get :destroy_users
    end
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
