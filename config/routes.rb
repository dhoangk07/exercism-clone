Rails.application.routes.draw do
  devise_for :users
  resources :exercises
  resources :solutions, only: [:create, :destroy]
  
  get 'tags/:tag', to: 'exercises#index', as: :tag
  root to: "exercises#index"
end
