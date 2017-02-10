Rails.application.routes.draw do
  devise_for :users , controllers: {omniauth_callbacks: "omniauth_callbacks"}
  get 'pages/info'

  resources :ideas
  root to: redirect('/ideas')
end
