Rails.application.routes.draw do
  resources :links, :posts
  resources :tags, only: [:index, :show]

  root 'pages#homepage'

  get    'login',  to: 'sessions#new'
  get    'auth',   to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
