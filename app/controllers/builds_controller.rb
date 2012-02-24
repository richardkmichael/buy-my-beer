# TODO:
#  1/ Before filter rescues: what if project and user do not exist?
#  2/ show() action for HTML redirect response.
#  3/ new() template (no action required) for bad HTML create().

# require 'awesome_print'

# ap "LOAD_PATH"
# ap $LOAD_PATH

require 'travis_build'
require 'pry'

class BuildsController < ApplicationController

  # Can wrap_parameters help us?
  # if ! params[:build]
  #   wrap_parameters :format => :json, :include => [ only travis build attrs we want ]
  # end

  # Rails will inspect the Build model and automatically wrap up known attributes into a
  # :build => { ... } hash.
  wrap_parameters false

  #
  # skip_before_filter :authenticate_user

  respond_to :html, :json

  before_filter :identify_build
  before_filter :sanity_check_params, :find_project, :find_last_commiter

  def create
    puts "DEBUG: #{__method__}"
    build = @project.builds.create(params[:build])
    respond_with(build.project, build)
  end

  protected

  def sanity_check_params
    puts "DEBUG: #{__method__}"
    puts "DEBUG: params[:build] = #{params[:build]}"
    puts "DEBUG: params[:project_id] = #{params[:project_id]}"

    unless params[:build] && params[:project_id]
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity }
        format.json { head :unprocessable_entity }
      end
    end
  end

  def find_project
    puts "DEBUG: #{__method__}"
    @project = Project.find_by_id(params[:project_id])
    unless @project
      respond_to do |format|
        # This response should indicate the :project_id is required.
        format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity }
        format.json { head :unprocessable_entity }
      end
    end
  end

  def find_last_commiter
    puts "DEBUG: #{__method__}"
    # If user is not found, should add 'User does not exist' error, not 'cannot be blank'.
    params[:build][:last_commiter] = User.find_by_email(params[:build][:last_commiter])
  end

  # This could be re-factored to "identify_build()" and "construct_build()".
  def identify_build

    puts "DEBUG: #{__method__}"
    puts "DEBUG: params.class = #{params.class}"
    puts "DEBUG: params.inspect = #{params.inspect}"
    puts "DEBUG: params[:build] = #{params[:build]}"
    puts "DEBUG: params[:commit] = #{params[:commit]}"
    puts "DEBUG: params[:status_message] = #{params[:status_message]}"

    # Below is surely insane: if there's no top-level :build in the params,
    # check if there are :commit and :status_message (e.g. look for TravisBuild
    # attributes).  If they exist, try creating a new TravisBuild from the JSON
    # in the request body.


    if ! params[:build] && params[:commit] && params[:status_message]
      # binding.pry
      travis_build = TravisBuild.from_json(request.body.read)

      puts "DEBUG: travis_build #{travis_build.inspect}"

      # A build does not need very many attributes; set it up from the Travis build.
      params[:build] = Hash.new
      params[:build][:status]         = travis_build.status
      params[:build][:last_commit]    = travis_build.last_commit
      params[:build][:last_commiter]  = travis_build.last_commiter

    end

  end
end
