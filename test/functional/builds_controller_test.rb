require "test_helper"

class BuildsControllerTest < ActionController::TestCase

  # def setup
  #   DatabaseCleaner.start
  # end

  # def teardown
  #   DatabaseCleaner.clean
  # end

  test 'it must create a build when sent JSON' do
    @build = Factory.build :build

    puts @build

    assert_equal @build.class, Build

    # post :create, :format => :json, :build => @build.to_json, :uuid => @build.project.uuid
    post :create, :format => :json, :build => @build, :uuid => @build.project.uuid

    # puts @response
    # puts @response.body

    assert_response :success
    # assert_difference 'Build.count' do
    # end
  end

end
