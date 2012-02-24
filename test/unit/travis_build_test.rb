require 'test_helper'
require File.join(Rails.root, 'lib/travis_build.rb')

# This model does not touch the database.
class TravisBuildTest < ActiveSupport::TestCase

  def setup
    json = File.read('test/fixtures/travis_build.json')
    @travis_build = TravisBuild.from_json(json)
  end

  # setup() would fail if this didn't work, but test it anyway in case setup() changes.
  test 'it must initialize from JSON' do
    json = File.read('test/fixtures/travis_build.json')
    travis_build = TravisBuild.from_json(json)
    assert_kind_of TravisBuild, travis_build
  end

  test 'it must provide the commit SHA1' do
    assert_respond_to @travis_build, :last_commit
    assert_equal @travis_build.last_commit, '62aae5f70ceee39123ef'
  end

  test 'it must provide the last commiter email address' do
    assert_respond_to @travis_build, :last_commiter
    assert_equal @travis_build.last_commiter, 'svenfuchs@artweb-design.de'
  end

  test 'it must provide the build status as a boolean' do
    assert_respond_to @travis_build, :status
    refute @travis_build.status, 'The test build should be false, JSON status is null.'
  end

end
