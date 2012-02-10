class BuildsController < ApplicationController

  respond_to :html, :json

  before_filter :find_project, :find_last_commiter

  def create
    build = @project.builds.new(params[:build])
    respond_with(build.project, build)
  end

  protected

  def find_project
    @project = Project.find_by_id(params[:project_id])
  end

  def find_last_commiter
    params[:build][:last_commiter] = User.find_by_email(params[:build][:last_commiter])
  end

end
