BuyMyBeer::Application.routes.draw do

# class JSONApiRequestConstraint
#   def self.matches?(request)
#     request.env['CONTENT_TYPE'] == 'application/vnd.build-v1+json'  # config/initializers/mime_types.rb
#   end
# end

# scope :constraints => JSONApiRequestConstraint do
#   post '/projects/:uuid', :constraints => { :uuid => /[0-9a-f]{64}/ },
#                           :to => 'builds#create',
#                           :as => create_json_build
# end

  resources :projects do
    resources :builds, :only => :create
  end

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  root :to => 'pages#welcome'
end
