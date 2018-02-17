# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  mount Vimo::Engine => "/vimo"
end
