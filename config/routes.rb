BuyMyBeer::Application.routes.draw do

  class JSONApiRequestConstraint
    def self.matches?(request)
      request.env['CONTENT_TYPE'] == 'application/vnd.build-v1+json'  # config/initializers/mime_types.rb
    end
  end

  # TODO: Q: How does Rails know what :uuid is?  (e.g. integer, the entire remaining string, etc.)
  # TODO: Q: How to make this a named route, so we can have _path/_url helpers?
  # TODO: Q: Is this a resourceful route?  Should it be nested under "resources :projects do .. " ?
  scope :constraints => JSONApiRequestConstraint do
    post '/projects/:uuid', :constraints => { :uuid => /[0-9a-f]{64}/ }, :to => 'builds#create'
  end

  # TODO: Q: Should we expose builds at all?
  resources :projects, :builds, :users

  match '/login', :to => 'users#new'

  root :to => 'projects#index'
end
