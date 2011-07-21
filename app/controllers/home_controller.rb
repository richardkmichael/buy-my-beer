class HomeController < PagesController

  before_filter :authenticate_user!

  def index
    @message = 'Home#index'
    @current_user = current_user

    @projects = current_user.projects
  end

  def user_root
    @message = 'Hello, User Root World!'
    @current_user = current_user
  end

end
