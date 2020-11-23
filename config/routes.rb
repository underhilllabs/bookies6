Rails.application.routes.draw do
  resources :bookmarks
  get "search" => "search#index", as: "search"
  resources :bookmarklet, only: [:new, :create, :show]
  
  get "tags/name/:name" => "tags#show_name", as: "tags_name"
  # get "bookmarks/archive/:id" => "bookmarks#archive", :as => "archive_bookmark"
  resources :bookmark_archives, only: [:show]

  devise_for :users
  resources :users, only: [:show, :index] do
    resources :bookmarks, only: [:index]
  end
  resources :tags, only: [:show, :index]
  root to: "bookmarks#index"

  post "api/posts/add.json" => "bookmarks#add_bookmark"
end
