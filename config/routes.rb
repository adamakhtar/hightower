Hightower::Engine.routes.draw do
  resources :segments, only: [:index]
  root to: 'segments#index'
end
