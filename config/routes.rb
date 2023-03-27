Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/dashboard", to: "pages#dashboard"
  get "/dashboard/pokemons/:id", to: "pages#dashboard_show", as: :dashboard_show
  post "/user_pokemons/:id/evolve", to: "user_pokemons#evolve", as: :user_pokemon_evolve

  resources :quizzes, only: [:create, :new, :show]
  resources :quiz_questions, only: [:show, :update, :edit]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
