require 'test_helper'
require File.join(Rails.root, 'lib/travis_build.rb')

# This model does not touch the database.
class TravisBuildTest < ActiveSupport::TestCase

  def setup
    json = File.read('test/fixtures/travis_build.json')
    @travis_build = TravisBuild.from_json(json)
  end

  test 'it must initialize from JSON' do
    json = File.read('test/fixtures/travis_build.json')
    travis_build = TravisBuild.from_json(json)
    assert_kind_of TravisBuild, travis_build
  end

  test 'it must be provide the commit SHA1' do
    assert_respond_to @travis_build, :commit
    assert_equal @travis_build.commit, '62aae5f70ceee39123ef'
  end
end
