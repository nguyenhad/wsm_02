Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  namespace :admin do
    root "static_pages#home"
    resources :users
  end

  namespace :dashboard do
    resources :workspaces
    resources :time_sheets
    resources :set_timesheets, only: :create
    resources :projects, except: :show
    resources :users
    resources :request_offs
    resources :request_leaves
    resources :set_users, only: :create
    resources :companies
  end
end
