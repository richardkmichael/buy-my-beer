class ProjectsController < ApplicationController

  # before_filter :authenticate_user!

  def index
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
      @project = Project.includes(:builds => :last_commiter).find(params[:id])
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

    redirect_to root_path
  end

end
