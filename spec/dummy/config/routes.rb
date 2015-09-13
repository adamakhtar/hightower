Rails.application.routes.draw do
  root to: 'home#index'

  mount Hightower::Engine => "/hightower"

  devise_for :users
end
