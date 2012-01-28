class PagesController < ApplicationController
  def welcome
    redirect_to projects_path if current_user
  end
end
