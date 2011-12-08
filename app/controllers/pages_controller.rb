class PagesController < ApplicationController
  def welcome
    # I know something to be wrong with this .. feels horrible.
    @user = params[:user] ? User.find(params[:user]) : nil
  end
end
