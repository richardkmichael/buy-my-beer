class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  # This action is actually doing auth too; ugh.  Needs a LoginController.
  def create

    # # Could try using our own User.authenticate().
    # @user = User.new(params[:user]
    # if User.authenticate(@user.email, @user.password)
    #   redirect_to @user
    # else
    #   if @user.valid?
    #     @user.save
    #     redirect_to @user
    #   else
    #     render 'new' # Is render() terminating?
    #   end
    # end
    # # Refactor and do: "redirect_to @user" here.


    # Order matters, create a new user if find fails.
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
