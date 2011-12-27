class SessionsController

  # Render the login form.
  def new
    @email    ||= 'E-mail'
    @password ||= 'Password'
  end

  # Authenticate or create the user.
  def create

    email    = params[:session][:email]
    password = params[:session][:password]

    if user = User.authenticate(email, password)
      flash[:notice] = 'Welcome back!'
      redirect_to user_path(user)

    elsif user = User.find_by_email(email)
      flash[:notice] = 'Incorrect password.'
      @email = email
      render 'new' #, :email => email

    else user = User.new(:email => email,
                         :password => password,
                         :password_confirmation => password)
      if user.valid?
        user.save
        flash[:notice] = 'Your account has been created.'
        redirect_to user_path(user)
      else
        flash[:notice] = 'There were errors creating your account.'
        render 'new' #, :email => email, :password => password
      end

    end
  end
end
