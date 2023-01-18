Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :movies, only: %i[index create], defaults: { format: :json }
  get "/movies/:filter", to: "movies#search", defaults: { format: :json }
end
