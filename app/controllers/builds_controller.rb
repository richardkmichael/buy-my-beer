class BuildsController < ApplicationController

  # TODO: A pattern for handling redirects?  If no @build, root_path; else, project_path(@build.project)
  def destroy
    begin
      @build = Build.find(params[:id])
      if @build.destroy
        flash[:success] = "Delete build '#{@build.name}' succeeded."
      else
        flash[:failure] = "Delete build failed: #{@build.errors.full_messages}."
      end

      redirect_to project_path(@build.project)

    rescue ActiveRecord::RecordNotFound => e
      flash[:failure] = "Delete build failed: #{e.message}."

      # TODO: Q: Use render() instead?  why round-trip to the browser?
      redirect_to root_path
    end
  end

end
