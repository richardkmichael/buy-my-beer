class ApplicationController < ActionController::Base
  protect_from_forgery

  # :before_filter :set_user
  # :before_filter :authenticate_user
  include ApplicationHelper
end
