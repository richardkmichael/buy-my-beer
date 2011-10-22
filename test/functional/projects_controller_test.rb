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

  include Devise::TestHelpers

  def setup
    DatabaseCleaner.start
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in Factory.create :user
  end

  def teardown
    DatabaseCleaner.clean
  end

  test 'it must show projects on the index page' do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test 'it must find a specific project' do
    project = Factory.create :project, :name => 'Show test project'

    get :show, :id => project.id
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test 'it must prepare an empty project form' do
    get :new
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test 'it must create a project and redirect to the index page' do
    assert_difference 'Project.count' do
      post :create, :project => { :name => 'Create test project' }
    end
    assert_redirected_to root_path
  end

  test 'it must delete a project and redirect to the index page' do
    project = Factory.create :project, :name => 'Destroy test project'

    assert_difference 'Project.count', -1 do
      post :destroy, :id => project.id
    end
    assert_redirected_to root_path
  end

  # This is probably an integration test.  The controller shouldn't care if the
  # data arrives as JSON or POST URL encoded parameters
  # test 'it must create a project by JSON' do
  #
  # end

end
