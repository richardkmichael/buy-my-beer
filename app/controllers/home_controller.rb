class HomeController < PagesController

  before_filter :authenticate_user!

  def index
    # TODO: Q: index.haml.html -> _project.haml.html which queries for users.  Eager load?
    @projects = current_user.projects
  end

  def user_root
    @message = 'Hello, User Root World!'
  end

end
