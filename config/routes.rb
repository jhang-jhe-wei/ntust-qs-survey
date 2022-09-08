# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'admin/recommenders#index'
  resources :recommenders, only: %i[new create]
  namespace :admin do
    root to: 'recommenders#index'
    resources :recommenders, only: %i[index new create update edit] do
      collection do
        get 'share'
        get 'upload', to: 'recommenders#upload'
        post 'upload', to: 'recommenders#upload_excel'
        get 'export', to: 'recommenders#export'
        post 'export', to: 'recommenders#export_csv'
        get 'download_template_excel', to: 'recommenders#download_template_excel'
      end
    end
  end
  resources :institutions, only: %i[index]
  get 'autocompletes/company_name', to: 'autocompletes#company_name'
  devise_for :users
end
