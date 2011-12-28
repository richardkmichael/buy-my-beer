require 'test_helper'

# These tests belong in ApplicationController.
class ProjectsControllerAuthenticationTest < ActionController::TestCase

  tests ProjectsController

  test 'it must refuse HTML if unauthenticated' do
    get :index
    assert_redirected_to new_session_path
  end

# test 'it must allow HTML if authenticated' do
#   # TODO: Must setup session for auth.
#   get :index
#   assert_response :success
# end

# test 'it must refuse JSON if unauthenticated' do
#   get :index, :format => :json
#   assert_response :unauthorized
# end

# test 'it must allow JSON if authenticated' do
#   # TODO: Must setup JSON body for auth.
#   get :index, :format => :json
#   assert_response :success
# end
end
