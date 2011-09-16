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
#
require "test_helper"

# class ProjectsControllerTest < MiniTest::Rails::Controller
class ProjectsControllerTest < ActionController::TestCase

  before do
    puts 'In before block.'
    @controller = ProjectsController.new
  end

  it 'must require authentication' do
    # How to test all authentication flavours?
    refute_nil @project
  end

  it 'must accept GitHub credentials' do

  end

  it 'must accept local credentials' do

  end

  it 'must respond to get' do
    get :index
    assert_response :success
  end

  it 'must create a project' do
    assert_difference(Project.count) do
      post :create, :project => { :name => 'A test project' }
    end

    # How does this work?
    assert_redirected_to project_path(assigns(:project))
    # assert_redirected_to project_path(@project)
  end

  it 'must respond to delete' do

  end

  it 'must setup specific template variables' do
    get :index
    assert_response :success
    # assert_not_nil assigns(@user)
  end
end
