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
        get 'download', to: 'recommenders#download_page'
        post 'download_excel', to: 'recommenders#download_excel'
        get 'download_template_excel', to: 'recommenders#download_template_excel'
      end
    end
  end
  get 'autocompletes/company_name', to: 'autocompletes#company_name'
  devise_for :users
end
