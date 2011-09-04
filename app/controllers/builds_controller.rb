class BuildsController < ApplicationController

  # POST JSON input, and create a build: /projects/:uuid
  # JSON values are put in params[]. See: config.wrap_parameters or wrap_parameters()
  def create
    begin
      @build = Build.new(params[:build])

      @build.project = Project.find_by_uuid(params[:uuid])

      @build.last_commiter = User.find_by_email(params[:last_commiter]) ||
                             User.new( :email => params[:last_commiter],
                                       :password => '*LOCKED*' )

      if @build.valid?

        # TODO: This belongs in model logic as a save hook / observer.
        # Failed builds cost a beer.
        @build.last_commiter.beers += 1 unless @build.status == true

        @build.save

        render :json => @build.to_json, :status => 200
      else
        render :json => "Invalid build! #{@build.to_json} => #{@build.errors.full_messages}", :status => 400
      end

    rescue MultiJson::DecodeError => e
      render :json => 'You sent malformed JSON, oops!', :status => 400
    end
  end

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

      redirect_to root_path
    end
  end

end
