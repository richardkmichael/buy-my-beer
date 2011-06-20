BuyMyBeer::Application.routes.draw do
  devise_for :users

  match '/home', :to => 'home#index'

  # Required for Devise ; as indicated by 'rails generate devise:install'.
  # user_root :to => 'home#user_root'
  root :to => 'home#index'
end
