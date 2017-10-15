Rails.application.routes.draw do
  namespace :projects do
    get 'time_sheet_for_week/show'
  end

  resources :works
  resources :pay_rates


  resources :time_sheets do
	  collection do
		  post 'hours_for_day/:date', to: "time_sheets#hours_for_day", as: '_hours'
	  end
  end

  get '/current_day/:time_period',to: "time_sheets#current_day", as: :current_day
  resources :customers
  resources :invoice_rows

  get 'invoice_row/new'
  resources :projects do

	  collection do
		  get :all_work_for_project
		  get '/hours_by_day/:id/' , to: 'projects#hours_by_day', as: :hours_by_day
		  get '/hours_by_user_by/:id' ,  to: 'projects#hours_by_user', as: :hours_by_user
		  get '/:id/time_sheets_for_week(.:format)', to: 'projects#time_sheets_for_week', as: :time_sheets_for_week
		  # resources :time_sheets_for_week
	  end
  end



  mount ActionCable.server => '/cable'
  resources :identities
  resources :projects
  resources :invoice_rows
  resources :invoices do
	  resources :invoice_rows
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks"}
    resources :users do
    resources :projects
    resources :identities
  end
  authenticate(:user) do
    resources :users do

	end
  end

  root to: 'time_sheets#index'
  get 'auth/:provider/callback', to: 'ideas#create'



end

