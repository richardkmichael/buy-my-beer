class HomeController < PagesController

  before_filter :authenticate_user!

  def index
    @message = 'Hello, Index World!'
    @current_user = current_user

    # @projects = User.find_by_id(current_user.id).projects
    @projects = current_user.projects
  end

  def user_root
    @message = 'Hello, User Root World!'
    @current_user = current_user
  end

end
