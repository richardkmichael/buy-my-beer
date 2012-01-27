# Test responses
# assert_response: [ :success, :redirect, :missing, :error ]
#  ---> ?? assert_equals @response.xxx, 200, "Oops, it failed." 
#
# Test actions
# get :show, post :create, etc.
# get() / post() accept
#
# Test HTTP verbs
#   get, post, put, head, delete
#   assigns, cookies, flash, session

require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  def setup
    DatabaseCleaner.start

    user = Factory.create :user
    @request.session[:user] = {}
    @request.session[:user][:id] = user.id
  end

  def teardown
    DatabaseCleaner.clean
  end

  # Randomize the action?
  test 'it must require authentication for HTML' do

    session_id = @request.session[:user][:id]
    @request.session[:user][:id] = nil

    get :new
    assert_redirected_to :new_session

    @request.session[:user][:id] = session_id

    get :new
    assert_response :success
  end

# test 'it must require authentication for JSON' do
#   get :new
#   assert_redirected_to :new_session

#   user = Factory.create :user
#   @request.session[:user] = {}
#   @request.session[:user][:id] = user.id

#   get :new
#   assert_response :success
# end

  # it 'must accept GitHub credentials' do
  #
  # end

  # it 'must accept local credentials' do
  #
  # end

  # it 'must respond to delete' do
  #
  # end

  # test 'setup specific template variables' do
  #   get :index
  #   assert_not_nil assigns(@user)
  # end

  # it 'must create a project' do
  #   assert_difference(Project.count) do
  #     post :create, :project => { :name => 'A test project' }
  #   end
  #
  #   # How does this work?
  #   assert_redirected_to project_path(assigns(:project))
  #   # assert_redirected_to project_path(@project)
  # end

end
