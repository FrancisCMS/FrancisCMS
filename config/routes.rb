FrancisCms::Engine.routes.draw do
  resources :links, :posts do
    resources :syndications, only: [:create, :destroy]
  end

  resources :tags, only: [:index, :show]
  resources :webmentions, except: [:new, :edit]
end
