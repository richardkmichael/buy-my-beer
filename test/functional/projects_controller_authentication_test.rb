# Auth tests smell suspiciously like integration tests, just like JSON vs. URL
# encoded form project creation in ProjectControllerTest.

require 'test_helper'

class ProjectsControllerAuthenticationTest < ActionController::TestCase

  include Devise::TestHelpers

  tests ProjectsController

  # Devise redirects (302 w/ Location) for navigational formats.
  test 'it must require authentication for HTML' do
    get :index, :format => :html
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test 'it must require authentication for JSON' do
    get :index, :format => :json
    assert_response 401
  end

  test 'it must accept local credentials' do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in Factory.create :user
  end

  # ==========================
  # # Mocking is required, because we can't store valid GH credentials here.
  # test 'it must accept GitHub credentials' do
  #
  # end

end
