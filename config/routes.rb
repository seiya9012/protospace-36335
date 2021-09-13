Rails.application.routes.draw do
  get 'prototypes/index'
  get 'prototype/index'
  root to: "prototypes#index"
end
