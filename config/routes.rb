Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :owners, only: %i[new create]
  resources :generals, only: %i[new create]

  # 一般ユーザー ログイン用のパス
  get 'general_login', to: 'general_sessions#new'
  post 'general_login', to: 'general_sessions#create'
  delete 'general_logout', to: 'general_sessions#destroy'
  root to: 'homes#index'

  namespace :admin do
    root to: 'dashboards#index'
    get 'owner_login', to: 'owner_sessions#new'
    post 'owner_login', to: 'owner_sessions#create'
  end

end
