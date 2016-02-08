FrancisCms::Engine.routes.draw do
  resources :links, :photos, :posts do
    resources :syndications, only: [:create, :destroy]

    post 'syndications/twitter', to: 'syndications#twitter', as: 'twitter_syndications'

    get 'archives',       on: :collection, to: 'archives#index'
    get 'archives/:year', on: :collection, to: 'archives#show', constraints: { year: /\d{4}/ }, as: 'archives_yearly'
  end

  resources :photos do
    post 'syndications/flickr', to: 'syndications#flickr', as: 'flickr_syndications'
  end

  resources :tags, only: [:index, :show]
  resources :webmentions, except: [:new, :edit]
end
