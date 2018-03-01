# frozen_string_literal: true

Vimo::Engine.routes.draw do
  defaults format: :json  do
    resources :entities, only: [:index, :show, :create, :update, :destroy] do
      resources :fields, only: [:index, :show, :create, :update, :destroy]
      resources :items, only: [:index, :show, :create, :update, :destroy]
    end

    resources :items, path: "resources/:entity_id", as: :resource,
      only: [:index, :show, :create, :update, :destroy]
  end
end
