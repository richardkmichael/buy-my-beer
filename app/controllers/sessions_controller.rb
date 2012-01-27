class SessionsController < ApplicationController

  # GET /sessions/new
  #   Display the login form.
  def new
    # render 'shared/_login_panel'
  end

  # POST /sessions
  #   Authenticate a user, creating a new user if they do not exist.
  #
  #   TODO: Creation should be behind the user service, though, in that
  #         case we won't know it found an existing user, or created one.
  def create

    email    = params[:email]
    password = params[:password]

    if user = User.authenticate(email, password)
      sign_in user
      flash[:notice] = 'Welcome back!'
      redirect_to user_path(user)

    elsif user = User.find_by_email(email)
      flash.now[:login_errors] = 'Incorrect password.'
      @email = email
      render :new

    else user = User.new(:email                 => email,
                         :password              => password,
                         :password_confirmation => password)

      if user.valid?
        user.save
        sign_in user
        flash[:notice] = 'Your account has been created.'
        redirect_to user_path(user)
      else
        flash[:notice] = 'There were errors creating your account.'
        @email = email
        @password = password
        render :new
      end

    end
  end

# def destroy
# end

end
