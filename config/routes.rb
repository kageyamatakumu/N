Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  resources :owners, only: %i[new create]
  resources :generals, only: %i[new create]

  # 一般ユーザー ログイン用のパス
  get 'general_login', to: 'general_sessions#new'
  post 'general_login', to: 'general_sessions#create'
  delete 'general_logout', to: 'general_sessions#destroy'

  # パスワードリセット
  resources :password_resets, only: %i[new create edit update]

  # 商品一覧（トップページ）
  root to: 'items#index'
  get 'items/search'

  get 'items/likes', to: 'items#likes'
  resources :likes, only: %i[create destroy]

  get 'items/history', to: 'items#histories'

  # 一般ユーザー アクション用
  resources :brands, only: %i[show] do
    resources :items, only: %i[show], controller: 'items'
  end

  namespace :admin do
    root to: 'dashboards#index'
    get 'owner_login', to: 'owner_sessions#new'
    post 'owner_login', to: 'owner_sessions#create'
    delete 'owner_logout', to: 'owner_sessions#destroy'
    resources :brands, only: %i[show new create edit update] do
      resources :items, only: %i[index new create show edit update destroy ], controller: 'items' do
        member do
          get 'confirm'
        end
      end
    end
  end

  get 'terms', to: 'terms#index'
  get 'privacy', to: 'privacies#index'
  get 'contact', to: "contacts#index"

end
