class ProjectsController < ApplicationController
  def new
    @project = Project.new
    @current_user = current_user
  end

  def create
    @project = Project.new(params[:project])
    # @project.users << current_user

    if @project.save
      flash[:success] = 'Project successfully created!'
      # TODO: Q: What's the best way to do this?
      redirect_to :controller => 'home', :action => 'index'
    else
      @project.name = nil

      # TODO: Q: 'new' requires @current_user, why isn't it defined?
      # TODO: Q: render() doesn't include layouts (so we miss flash messages), etc.?  Why?
      @current_user = current_user
      render :new
    end

  end
end
