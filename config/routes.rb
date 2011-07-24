BuyMyBeer::Application.routes.draw do

  resources :projects

  # Devise authentication for the user routes.
  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}

  # Required for Devise ; as indicated by 'rails generate devise:install'.
  # user_root :to => 'projects#user_root'
  root :to => 'projects#index'
end
