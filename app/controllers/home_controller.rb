class HomeController < PagesController

  before_filter :authenticate_user!

  def index
    # Eager load users to prevent the _project.html.haml view from querying.
    @projects = current_user.projects.includes(:users)
  end

  def user_root
    @message = 'Hello, User Root World!'
  end

end
