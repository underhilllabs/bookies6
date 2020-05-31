Rails.application.routes.draw do
  resources :bookmarks
  resources :bookmarklet, only: [:new, :create]
  
  get "tags/name/:name" => "tags#show_name", as: "tags_name"
  devise_for :users
  resources :users, only: [:show, :index] do
    resources :bookmarks, only: [:index]
  end
  resources :tags, only: [:show, :index]
  root to: "bookmarks#index"
end
