Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/dashboard", to: "pages#dashboard"
  get "/map", to: "pages#map"

  resources :quizzes, only: [:create, :new, :show]
  resources :quiz_questions, only: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
