Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  resources :books do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
  end

  get 'search' => 'searchs#search'

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  root 'home#top'
  get 'home/about'
  get 'users/:id/follow', to: 'users#follow', as: 'users_follow'
  get 'users/:id/follower', to: 'users#follower', as: 'users_follower'

end