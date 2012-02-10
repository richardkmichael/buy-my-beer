class BuildsController < ApplicationController

  def create
    build = Build.new( :status      => params[:build][:status],
                       :last_commit => params[:build][:last_commit] )

    # Find the owning project.
    build.project = Project.find_by_uuid(params[:build][:uuid])

    # Find the last commiter.
    build.last_commiter = User.find_by_email(params[:build][:last_commiter])

    # Save the build, respond with it as JSON.
    if build.valid?
      build.save
      render :status => 200,
             :json   => build
    else
      render :status => 400,
             :json   => { :message => 'Invalid build.',
                          :errors  => build.errors.full_messages,
                          :build   => build }
    end
  end

end
