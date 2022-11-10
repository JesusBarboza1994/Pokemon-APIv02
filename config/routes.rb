Rails.application.routes.draw do
  devise_for :users
  resources :real_stats
  resources :effort_stats
  resources :indiv_stats
  resources :pokemon_stats
  resources :stats
  resources :my_pokemons
  resources :types
  root to:"pokemons#index"
  resources :pokemons
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "/train", to: "my_pokemons#train"
  get "/train", to: "my_pokemons#train"

end
