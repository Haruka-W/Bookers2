Rails.application.routes.draw do

  root 'homes#top'
  get "home/about" => "homes#about"

  devise_for :users
  resources :books do
  	resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create]
  end
  resources :book_comments, only: [:destroy]
  resources :users
  # フォロー機能↓
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end

  # 検索機能↓
  get '/search' => 'search#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
