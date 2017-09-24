Rails.application.routes.draw do
  resources :works
  resources :time_sheets do
	  get 'days', to: 'time_sheets#add_day'
  end
  resources :customers
  get 'invoice_row/create'

  get 'invoice_row/new'
  resources :projects do
	  collection do
		  get :all_work_for_project
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
    resources :users
  end

  root to: redirect('/time_sheets')
  get 'auth/:provider/callback', to: 'ideas#create'

end

