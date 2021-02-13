Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :git_commits do
    get :latest_commits, on: :collection
  end

  resources :animated_gifs, only: :create
  resources :repos

  get  '/auth/:provider/callback', to: 'sessions#create', as: 'auth_callback'
  post '/auth/:provider/callback', to: 'sessions#create'

  resource :sessions, only: [:destroy]

  resource :users, only: [] do
    get 'account'
  end

  resources :users, only: :show
  root to: "main#index"
end
