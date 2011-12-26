class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # Can we assume params[:user] is a hash?
    @user = User.find_or_create_by_email(params[:user][:email], params[:user])

    # Hum.. assume if it is not persisted, then there were errors?
    if @user.persisted?
      # This action is actually doing auth too; ugh.  Needs a LoginController.
      if @user.has_password?(params[:password])
        flash[:notice] = 'Your account has been created.'
        redirect_to user_path(@user)
      else
        flash[:notice] = 'Bad password.'
        render 'new'
      end
    else
      flash[:notice] = 'There were errors creating your account.'
      render 'new'
    end
  end

end
