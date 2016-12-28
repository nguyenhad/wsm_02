Rails.application.routes.draw do

  devise_for :users
  root "static_pages#home"

  namespace :admin do
    root "static_pages#home"
    resources :users
  end

  namespace :dashboard do
    root "users#index"
    resources :workspaces do
      resources :time_sheets, only: :index
      resources :timesheet_settings, except: :destroy
    end
    resources :set_timesheets, only: [:create, :index]
    resources :projects, except: :show
    resources :users
    resources :request_offs
    resources :request_leaves
    resources :set_users, only: :create
    resources :companies
    resources :personal_issues
  end
  resources :request_offs
  resources :request_leaves
  resources :personal_issues
end
