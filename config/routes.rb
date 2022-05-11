Rails.application.routes.draw do
  root to: "recommenders#index"
  devise_for :users

end
