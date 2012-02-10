BuyMyBeer::Application.routes.draw do

  resources :projects do
    resources :builds, :only => [:create, :show]
  end

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  root :to => 'pages#welcome'

end
