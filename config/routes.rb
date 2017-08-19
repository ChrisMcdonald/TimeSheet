Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :identities
  resources :projects
  resources :invoices
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

