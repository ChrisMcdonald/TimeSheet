Rails.application.routes.draw do
  get 'invoice_row/create'

  get 'invoice_row/new'

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

  root to: redirect('/invoices')
  get 'auth/:provider/callback', to: 'ideas#create'

end

