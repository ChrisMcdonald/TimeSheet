# frozen_string_literal: true

Rails.application.routes.draw do
  get 'current_user' ,to: 'user#edit'
  patch 'current_user', to: 'user#update'
  resources :travels
  namespace :projects do
    get 'time_sheet_for_week/show'
  end
  resources :vehicles do
    resources :travels
  end
  resources :pay_rates
  resources :identities
  resources :projects do
    resources :invoices, except: [:edit], controller: 'projects/invoices'
  end
  resources :invoices, except: [:edit]
  resources :works
  get '/send_invoice' , to: 'invoices#send_invoice', as: :send_invoice
   resources :social_info
  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  resources :time_sheets do
    resources :travels
    collection do
      post 'hours_for_day/:date', to: 'time_sheets#hours_for_day', as: '_hours'
    end
  end

  get '/current_day/:time_period', to: 'days#index', as: :current_day
  resources :customers do
    get :details
  end

  resources :projects do
    collection do
      get :all_work_for_project
      get '/hours_by_day/:id/', to: 'projects#hours_by_day', as: :hours_by_day
      get '/hours_by_user_by/:id', to: 'projects#hours_by_user', as: :hours_by_user
      get '/:id/time_sheets_for_week(.:format)', to: 'projects#time_sheets_for_week', as: :time_sheets_for_week
      # resources :time_sheets_for_week
    end
  end

  mount ActionCable.server => '/cable'

  devise_for :users, path: :admin,
                     controllers: {
                         registrations: 'users/registrations',
                       sessions: 'users/sessions',
                       omniauth_callbacks: 'users/omniauth_callbacks',
                       # passwords: 'users/passwords'
                     }
  get 'auth/:provider/callback', to: 'time_sheet#index'



  authenticate(:user) do
    resources :users do
      resources :projects
      resources :identities
      resources :pay_rates
      scope module: "user" do
        resources :pay_obligations
      end
      get :user_data
      get :user_income
      get :user_permission
      post :user_permission
    end
  end

  root to: 'time_sheets#index'
end
