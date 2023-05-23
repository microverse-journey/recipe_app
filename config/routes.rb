# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  # Defines the root path route ("/")
  # root "articles#index"

    resources :recipes, only: %i[index show new create destroy] do
    end

  devise_scope :user do
    authenticated :user do
      root 'recipes#index', as: :authenticated_root
    end
    unauthenticated do
      root 'recipes#index', as: :unauthenticated_root
    end
  end
end
