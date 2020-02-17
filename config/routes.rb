Rails.application.routes.draw do
  root 'books#top'
  devise_for :users
  resources :books
  resources :users, only: [:show]
  delete '/books' => 'books#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
