class BuildsController < ApplicationController

  respond_to :html, :json

  def create
    build = Build.new( :status      => params[:build][:status],
                       :last_commit => params[:build][:last_commit] )

    # Find the owning project.
    logger.debug "DEBUG: Project ID: #{params[:project_id]}"
    build.project = Project.find_by_id(params[:project_id])

    # Find the last commiter.
    build.last_commiter = User.find_by_email(params[:build][:last_commiter])

    # If the build is valid, save it and give the conventional response.
    if build.valid? && build.save
      respond_with build
      # TODO: Use respond_to format.json, etc. instead.
    else

      # TODO: If for JSON, we must return JSON with errors.
      #       If for HTML, we must return a form with errors - but the UI never sees this.
      render :status => 400,
             :json   => { :message => 'Invalid build.',
                          :errors  => build.errors.full_messages,
                          :build   => build }
    end
  end

end
