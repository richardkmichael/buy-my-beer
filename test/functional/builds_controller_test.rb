require "test_helper"

class BuildsControllerTest < ActionController::TestCase

  def setup
    DatabaseCleaner.start
    assert_equal 0, Build.count, "There should be 0 builds, but there are #{Build.count}"

  end

  def teardown
    DatabaseCleaner.clean
    assert_equal 0, Build.count, "There should be 0 builds, but there are #{Build.count}"
  end

  test 'it must create a build when POSTed valid attributes' do

    # Use a factory to prepare related models; ensure the factory and validations agree.
    build = Factory.build :build
    assert build.valid?

    post :create, :build => { :uuid          => build.project.uuid,
                              :status        => build.status,
                              :last_commit   => build.last_commit,
                              :last_commiter => build.last_commiter.email }

    assert_response :success

    assert_block('Expected to response to be JSON.') { @response_build = JSON.parse @response.body }
    assert_kind_of Hash, @response_build

    assert_equal( @response_build['status'],           build.status )
    assert_equal( @response_build['last_commit'],      build.last_commit )
    assert_equal( @response_build['last_commiter_id'], build.last_commiter.id )

    assert_equal 1, Build.count, "There should be 1 build, but there are #{Build.count}"

  end

  test 'it must not create a build when POSTed invalid attributes' do

    # Use a factory to insure related models are prepared for the build.
    build = Factory.build :build
    assert build.valid?

    # Post without the required UUID.
    post :create, :build => { :status        => build.status,
                              :last_commit   => build.last_commit,
                              :last_commiter => build.last_commiter.email }

    assert_response :bad_request

    assert_block('Expected to response to be JSON.') { @response_json = JSON.parse @response.body }
    assert_kind_of Hash, @response_json

    assert_match @response_json['message'], /^Invalid build/

    assert_equal 0, Build.count, "There should be 0 build(s), but there are #{Build.count}"

  end
end
