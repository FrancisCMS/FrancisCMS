Rails.application.routes.draw do
  resources :posts

  root 'pages#homepage'
end
