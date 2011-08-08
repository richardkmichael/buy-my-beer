class BuildsController < ApplicationController

  # TODO: What to do about the CSRF warning?  See the development log.
  # TODO: If Builds are RESTful, then return "201 Created", and use the Location header
  #       to indicate a path to the build.  See: HTTP RFC 2616 10.2.2
  # TODO: Check the 'Accept' header to see what the client wants.
  # TODO: BuildController#create integration test for the POST JSON.

  # POST JSON input, and create a build.
  # /projects/:uuid
  def create

    begin
      # Rails will parse JSON POSTs and put the values in params[]
      # See also: config.wrap_parameters or wrap_parameters()
      @build = Build.new(params[:build])

      @build.project = Project.find_by_uuid(params[:uuid])

      if @build.valid?
        @build.save
        render :json => @build.to_json, :status => 200
      else
        render :json => "Invalid build! #{@build.to_json} => #{@build.errors.full_messages}", :status => 400
      end

    rescue MultiJson::DecodeError => e
      # TODO: I can't seem to rescue MJ::DE here, something higher up is throwing it.
      # TODO: Provide a better message here.
      render :json => 'You sent malformed JSON, oops!', :status => 400
    end

  end

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
