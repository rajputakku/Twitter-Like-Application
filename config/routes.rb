Rails.application.routes.draw do
  root to: 'posts#index'
  # resources :posts do
  #   resources :comments
  # end
  resources :posts do
    resources :likes, only: [:create, :destroy]

    resources :comments do
      resources :likes, only: [:create, :destroy]
    end

  end
  
  devise_for :users
  get '/draft',to: 'posts#draft',as: :draft
  get 'publish_post/:id', to: 'posts#publish_post',as: :publish_post

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
