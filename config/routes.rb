Rails.application.routes.draw do
  resources :customers
  resources :messages
  resources :projects
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks"}
  get 'pages/info'
  resources :ideas ,:profile
  # resources :users do
  #   resources :identities
  # end
  resources :users do
    resources :projects
  end
  authenticate(:user) do
    resources :users

  end
  resources :projects do
    resources :customers, :messages

  end
  root to: redirect('/ideas')
  get 'auth/:provider/callback', to: 'ideas#create'

  post 'profile/send_email'

end

