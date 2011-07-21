class ProjectsController < ApplicationController

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

  def destroy
    @project = Project.find(params[:project])

    if @project.destroy
      flash[:success] = 'Delete project succeeded.'
    else
      flash[:failure] = "Delete project failed: #{@project.errors.full_messages}."
    end

    # There is no destroy.html.haml, always redirect to the index.
    # TODO: Q: Use render() instead?  Why round-trip to the browser?
    redirect_to root_path
  end

end
