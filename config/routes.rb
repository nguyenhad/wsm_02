Rails.application.routes.draw do

  devise_for :users
  root "static_pages#home"
  namespace :admin do
    root "static_pages#home"
    resources :users
  end

  namespace :dashboard do
    resources :workspaces
    resources :set_timesheets, only: [:create, :index]
    resources :projects, except: :show
    resources :users
    resources :request_offs
    resources :request_leaves
    resources :set_users, only: :create
    resources :companies do
      resources :time_sheets, only: :index
    end
    resources :personal_issues
  end
  resources :request_offs, only: [:index, :destroy]

end
