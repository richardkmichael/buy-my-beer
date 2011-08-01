BuyMyBeer::Application.routes.draw do

  # TODO: We need a scoped match for creating a build.
  # TODO: e.g. we want JSON to http://localhost/project/<sha1> to create a new build.
  resources :projects

  # TODO: Q: Should we expose builds at all?
  resources :builds

  # Devise authentication for the user routes.
  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}

  # Required for Devise ; as indicated by 'rails generate devise:install'.
  # user_root :to => 'projects#user_root'
  root :to => 'projects#index'
end
