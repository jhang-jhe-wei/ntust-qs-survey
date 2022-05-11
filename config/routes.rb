Rails.application.routes.draw do
  root to: "recommenders#index"
  resources :recommenders, only: [:index, :new, :create]
  devise_for :users
end
