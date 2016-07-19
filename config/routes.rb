FrancisCms::Engine.routes.draw do
  resources :links, :photos, :posts do
    resources :syndications, only: [:create, :destroy]

    get 'archives',       on: :collection, to: 'archives#index'
    get 'archives/:year', on: :collection, to: 'archives#show', year: /\d{4}/, as: 'annual_archives'
  end

  resources :tags, only: [:index, :show]
  resources :webmentions, except: [:new, :edit]
end
