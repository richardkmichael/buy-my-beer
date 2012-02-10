# TODO:
#  1/ Before filter rescues: what if project and user do not exist?
#  2/ show() action for HTML redirect response.
#  3/ new() template (no action required) for bad HTML create().

class BuildsController < ApplicationController

  respond_to :html, :json

  before_filter :find_project, :find_last_commiter

  def create
    build = @project.builds.create(params[:build])
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
