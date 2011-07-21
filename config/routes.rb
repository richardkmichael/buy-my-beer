BuyMyBeer::Application.routes.draw do

  resource :projects

  # Devise authentication for the user routes.
  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}

  # Required for Devise ; as indicated by 'rails generate devise:install'.
  # user_root :to => 'home#user_root'
  root :to => 'home#index'
end
