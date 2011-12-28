module ApplicationHelper

  def sign_in(user)
    # Don't put the entire User in the session; however, create a user hash
    # so we can store values nicely.
    session[:user] ||= {}
    session[:user][:id] = user.id
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    case request.format
    when 'text/html'
      @current_user ||= user_from_session
    when 'application/json'
      @current_user ||= user_from_json
    end
  end

  # Use as "before_filter :authenticate_user".
  def authenticate_user
    case request.format
    when  'text/html'
      redirect_to new_session_path unless current_user
    when 'application/json'
      head :unauthorized           unless current_user
    end

  end

  private

  # TODO: This is called from current_user(), a view helper method.
  #       Thus, views query the database.  The controller should set up
  #       @current_user, and the view should use it.
  def user_from_session
    if session[:user] && session[:user][:id]
      User.find_by_id(session[:user][:id])
    else
      nil
    end
  end

  # Doing auth here is strange... ?  HTML does auth in SessionsController#create.
  # This method is essentially SessionsController#create, except we do not automatically
  # create a user if they do not exist.  Thus, the JSON API semantics are different than
  # the interactive site semantics (auto-account creation, for example).  This is strange.
  #
  # TODO: Get email, password from :params[] instead of parsing request.body?
  def user_from_json
    json = JSON.parse request.body

    username = json['authentication']['email']
    password = json['authentication']['password']

    if user = User.authenticate(email, password)
      user
    else
      nil
    end
  end

end
