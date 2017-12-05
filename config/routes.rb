Rails.application.routes.draw do
  resources :travels
	namespace :projects do
		get 'time_sheet_for_week/show'
	end

	resources :identities
	resources :projects
	resources :invoices, :except => [:edit]
	resources :works
	resources :pay_rates


	resources :time_sheets do
		get :travel
		collection do
			post 'hours_for_day/:date', to: "time_sheets#hours_for_day", as: '_hours'
		end
	end

	get '/current_day/:time_period', to: "time_sheets#current_day", as: :current_day
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


	# mount ActionCable.server => '/cable'

	devise_for :users, path: :admin,
			   controllers: {#registrations: "users/registrations",
				 sessions: 'users/sessions',
				 omniauth_callbacks: 'users/omniauth_callbacks'
         			   }

	resources :users do
		resources :projects
		resources :identities
		get :user_data
		get :user_income
		get :user_permission
		post :user_permission
		get 'auth/:provider/callback', to: 'time_sheets#index'

	end

	authenticate(:user) do
		resources :users do

		end
	end

	root to: 'time_sheets#index'


end

