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

    post :create, { :project_id => build.project_id,
                    :build      => { :status        => build.status,
                                     :last_commit   => build.last_commit,
                                     :last_commiter => build.last_commiter.email } }

    # HTML POSTs are sent to the show page.
    assert_response :redirect

    assert_equal 1, Build.count, "There should be 1 build, but there are #{Build.count}"

  end

  test 'it must create a build when JSON POSTed valid attributes' do

    # Use a factory to prepare related models; ensure the factory and validations agree.
    build = Factory.build :build
    assert build.valid?

    post :create, { :format     => :json,
                    :project_id => build.project_id,
                    :build      => { :status        => build.status,
                                     :last_commit   => build.last_commit,
                                     :last_commiter => build.last_commiter.email } }

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

    # POST without the required status attribute.
    post :create, { :project_id => build.project_id,
                    :build      => { :last_commit   => build.last_commit,
                                     :last_commiter => build.last_commiter.email } }

    # Bad HTML POSTs are 200, and render the new template.
    assert_response :success

    # TODO: Need an assert on new template content?

    assert_equal 0, Build.count, "There should be 0 build(s), but there are #{Build.count}"

  end

  test 'it must not create a build when JSON POSTed invalid attributes' do

    # Use a factory to insure related models are prepared for the build.
    build = Factory.build :build
    assert build.valid?

    # POST without the required status attribute.
    post :create, { :format     => :json,
                    :project_id => build.project_id,
                    :build      => { :last_commit   => build.last_commit,
                                     :last_commiter => build.last_commiter.email } }

    # Bad JSON POSTs are 422, with a JSON body of errors.
    assert_response :unprocessable_entity

    assert_block('Expected to response to be JSON.') { @response_json = JSON.parse @response.body }
    assert_kind_of Hash, @response_json

    assert_equal ['is not included in the list'], @response_json['errors']['status']

    assert_equal 0, Build.count, "There should be 0 build(s), but there are #{Build.count}"

  end

end
