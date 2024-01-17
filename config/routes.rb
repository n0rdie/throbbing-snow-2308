Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :flights, only: :index do
    resources :passengers, only: [:destroy], controller: "flights/passengers"
  end
  resources :airlines, only: :show
end