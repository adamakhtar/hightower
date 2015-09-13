Hightower::Engine.routes.draw do
  resources :events, only: [:index]
  resources :segments, only: [:index]
  root to: 'segments#index'
end
