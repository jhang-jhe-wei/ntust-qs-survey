Rails.application.routes.draw do
  root to: "admin/recommenders#index"
  resources :recommenders, only: [:new, :create]
  namespace :admin do
    root to: "recommenders#index"
    resources :recommenders, only: [:index, :new, :create] do
      collection do
        get 'share'
        get 'upload', to: 'recommenders#upload_page'
        post 'upload', to: 'recommenders#upload'
        get 'download', to: 'recommenders#download_page'
        post 'download', to: 'recommenders#download'
      end
    end
  end
  devise_for :users
end
