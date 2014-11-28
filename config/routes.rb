Rails.application.routes.draw do
  resources :links
  resources :posts

  root 'pages#homepage'
end
