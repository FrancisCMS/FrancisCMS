Rails.application.routes.draw do
  resources :links
  resources :posts

  root 'pages#homepage'

  get    'login'  => 'sessions#new'
  get    'auth'   => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
