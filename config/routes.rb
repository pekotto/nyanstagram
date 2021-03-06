Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#top'
  get 'home/about' => 'home#about'


  devise_for :users, controllers: {
   sessions:      'users/sessions',
   passwords:     'users/passwords',
   registrations: 'users/registrations',
   omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:index, :create, :show]
  resources :relationships, only: [:create, :destroy]
  resources :contacts, only: [:new, :create]

  get 'posts/like_posts' => 'posts#like_posts'
  get 'posts/following_posts' => 'posts#following_posts'
  get 'posts/follower_posts' => 'posts#follower_posts'
  get 'posts/breeds' => 'posts#breeds'

  resources :posts do
     resource :comments, only: [:create, :destroy]
     resource :likes, only: [:create, :destroy]
  end

  get '/search' => 'search#index', as: 'search'
  get '/search/index2' => 'search#index2'
  get '/search/result' => 'search#result'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
