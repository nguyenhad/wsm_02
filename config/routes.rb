Rails.application.routes.draw do
  devise_for :users

  root "static_pages#home"

  namespace :admin do
    root "static_pages#home"
    resources :users
  end
end