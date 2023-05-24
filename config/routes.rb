# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  # Defines the root path route ("/")
  # root "articles#index"
    resources :users, only: %i[index show]
    resources :recipes, only: %i[index show new create destroy] do
      resources :recipe_foods, only: %i[new create destroy]
    end

    get '/public_recipes', to: 'recipes#public_recipes', as: :public_recipes

  resources :foods

    authenticated :user do
      root 'recipes#index', as: :authenticated_root
    end

    unauthenticated do
      root 'recipes#public_recipes', as: :unauthenticated_root
    end
end
