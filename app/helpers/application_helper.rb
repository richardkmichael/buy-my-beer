module ApplicationHelper

  def sign_in(user)
    # Don't put the entire User in the session; however, create a user hash
    # so we can store values nicely.
    session[:user] ||= {}
    session[:user][:id] = user.id
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_session
  end

  def authenticate_user
    redirect_to(login_path) unless session[:user] && session[:user][:id]
  end

  private

  # TODO: This is called from current_user(), a view helper method.
  #       Thus, views query the database.  The controller should set up
  #       @current_user, and the view should use it.
  def user_from_session
    # logger.debug "DEBUG: #{session[:user]}, #{session[:user][:id]}"
    if session[:user] && session[:user][:id]
      User.find_by_id(session[:user][:id])
    else
      nil
    end
  end
end
