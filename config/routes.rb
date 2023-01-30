Rails.application.routes.draw do
  mount Rswag::Ui::Engine => 'api-docs'
  mount Rswag::Api::Engine => 'api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :lists
  root 'lists#index'
  # Defines the root path route ("/")
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
