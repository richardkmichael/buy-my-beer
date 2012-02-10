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
      render :json   => build,
             :status => 200
    else
      render :json   => { :message => 'Invalid build.',
                          :errors  => build.errors.full_messages,
                          :build   => build },
             :status => 400
    end
  end

# def destroy
#   begin
#     @build = Build.find(params[:id])
#     if @build.destroy
#       flash[:success] = "Delete build '#{@build.name}' succeeded."
#     else
#       flash[:failure] = "Delete build failed: #{@build.errors.full_messages}."
#     end

#     redirect_to project_path(@build.project)

#   rescue ActiveRecord::RecordNotFound => e
#     flash[:failure] = "Delete build failed: #{e.message}."

#     redirect_to root_path
#   end
# end

end
