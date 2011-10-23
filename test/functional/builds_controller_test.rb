require "test_helper"

class BuildsControllerTest < ActionController::TestCase

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  # test 'it must only allow creation by POST of JSON' do
  #   # This is a router test.
  # end

  test 'it must respond with success after a create build' do

    # Use a factory to prepare the database with everything for the POSTed build to validate.
    build = Factory.build :build
    assert_equal build.class, Build

    assert_difference 'Build.count' do
      post :create, :format        => :json,
                    :last_commiter => build.last_commiter.email,
                    :uuid          => build.project.uuid,
                    :build         => { :status => build.status,
                                        :last_commit => build.last_commit },
    end

    assert_response :success
  end

  # This should really be two tests.
  test 'it must redirect to the project page after a delete ' do
    build = Factory.create :build

    assert_difference 'Build.count', -1 do
      post :destroy, :id => build.id
    end
    assert_redirected_to project_path(build.project)
  end

  test 'it must redirect to the index page after a failed delete' do
    post :destroy, :id => '100' # build.id = 100 does not exist.
    assert_redirected_to root_path
  end

end
