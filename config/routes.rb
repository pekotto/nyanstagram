Rails.application.routes.draw do

  root 'home#top'

  devise_for :admins, controllers: {
   sessions:      'admins/sessions',
   passwords:     'admins/passwords',
   registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
   sessions:      'users/sessions',
   passwords:     'users/passwords',
   registrations: 'users/registrations'
  }

 namespace :admin do
    resources :favorite_breeds
  end

  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  get 'posts/likes' => 'posts#likes'
  get 'posts/following_posts' => 'posts#following_posts'
  get 'posts/follower_posts' => 'posts#follower_posts'
  get 'posts/breeds' => 'posts#breeds'

  resources :posts do
     resources :comments, only: [:create, :destroy]
     resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
