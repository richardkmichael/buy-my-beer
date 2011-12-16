class PagesController < ApplicationController

  # before_filter :authenticate_user!

  def welcome
    # I know something to be wrong with this .. feels horrible.
    # @user = params[:user] ? User.find(params[:user]) : nil
  end
end
