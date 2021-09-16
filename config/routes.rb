Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  get 'prototype/index'
  root to: "prototypes#index"
end
