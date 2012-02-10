class BuildsController < ApplicationController

  respond_to :html, :json

  before_filter :find_project, :find_last_commiter

  def create

    build = @project.builds.new(params[:build])
    respond_with(build.project, build)

#     if build.valid? && build.save
#       respond_with(build.project, build)
#     else

#       # TODO: If for JSON, we must return JSON with errors.
#       #       If for HTML, we must return a form with errors - but the UI never sees this.
#       render :status => 400,
#              :json   => { :message => 'Invalid build.',
#                           :errors  => build.errors.full_messages,
#                           :build   => build }
#     end
  end

  protected

  def find_project
    @project = Project.find_by_id(params[:project_id])
  end

  def find_last_commiter
    params[:build][:last_commiter] = User.find_by_email(params[:build][:last_commiter])
  end

end
