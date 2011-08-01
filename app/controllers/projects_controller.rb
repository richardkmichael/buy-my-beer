class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  def index
    # Eager load users to prevent the _project.html.haml view from querying.
    @projects = current_user.projects.includes(:users)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.users << current_user

    if @project.save
      flash[:success] = 'Create project succeeded.'
      redirect_to root_path
    else
      flash[:failure] = "Create project failed: #{@project.errors.full_messages}."
      render :new, :layout => true
    end
  end

  def show
    begin
      # @project = Project.find(params[:id])
      @project = Project.includes(:builds).find(params[:id])

      # TODO: Q: How to eager load the User/commiter data on the builds?
      # TODO:    This is looking for Project.last_commiter.
      # @project = Project.includes(:builds).includes(:last_commiter).find(params[:id])
      # @builds = @project.builds.includes(:last_commiter)
      @builds = Build.includes(:last_commiter).find_all_by_id(@project.id)

      # if @project
      #   render @project
      # else
      #   flash[:failure] = "Show project failed: #{@project.errors.full_messages}."
      # end
    rescue ActiveRecord::RecordNotFound => e
      flash[:failure] = "Show project failed: #{e.message}."
      redirect_to root_path
    end
  end

  def destroy
    begin
      @project = Project.find(params[:id])
      if @project.destroy
        flash[:success] = "Delete project '#{@project.name}' succeeded."
      else
        flash[:failure] = "Delete project failed: #{@project.errors.full_messages}."
      end
    rescue ActiveRecord::RecordNotFound => e
      flash[:failure] = "Delete project failed: #{e.message}."
    end

    # There is no destroy.html.haml, always redirect to the index.
    # TODO: Q: Use render() instead?  Why round-trip to the browser?
    redirect_to root_path
  end

  ############################

  def user_root
    @message = 'Hello, User Root World!'
  end

end
