Rails.application.routes.draw do
  get 'users/rank'

  root to: 'home#index'

  devise_for :users
  # 上の get 'users/rank' と被ってる
  resources :users, only: [] do
    collection do
      get :rank
    end
  end

  resources :bokes, only: [] do
    collection do
      get :recent
      get :popular
      get :hall_of_fame
    end
  end

  resources :themes, only: [:index, :show] do
    resources :bokes, only: [:index, :show]
  end

  namespace :my do
    get 'page', to: 'page#show', as: 'page'
    resources :themes, only: [:index, :new, :create, :edit, :update, :destroy]  do
      resources :bokes, only: [:new, :create, :edit, :update, :destroy]  do
        resources :evaluations, only: [:new, :create, :destroy]
      end
    end
    resources :bokes, only: [:index]
    # 他のユーザーの情報を閲覧するコントローラが my にあるのは違和感
    resources :users, only: [:show] do
      member do
        post :follow
        post :unfollow
      end
    end
  end
end
