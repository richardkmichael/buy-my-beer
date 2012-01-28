class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  # This action is actually doing auth too; ugh.  Needs a LoginController.
  def create

    # Order matters: create a new user if find fails.
    @user = User.find_by_email(params[:user][:email]) || User.new(params[:user])

    if @user.new_record?

      if @user.valid?
        @user.save
        flash[:notice] = 'Your account has been created.'
        sign_in(@user)
        redirect_to user_path(@user)
      else
        flash[:notice] = 'There were errors creating your account.'
        render 'new'
      end

    else

      if @user.has_password?(params[:user][:password])
        flash[:notice] = 'Welcome back!'
        sign_in(@user)
        redirect_to user_path(@user)
      else
        flash[:notice] = 'Incorrect password.'
        @user = User.new(:email => @user.email)
        render 'new'
      end

    end
  end

end
