Hightower::Engine.routes.draw do
  resources :events, only: [:index]
  resources :segments, only: [:index]
  resources :users, only: [:index, :show]
  root to: 'segments#index'
end
