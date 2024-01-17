Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/flights", to: "flights#index"
  delete "/flights/:flight_id/passengers/:id", to: "flights/passengers#destroy"
  get "/airlines/:id", to: "airlines#show"
end