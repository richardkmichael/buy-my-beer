require 'test_helper'

class BuildTest < ActiveSupport::TestCase

  def setup
    DatabaseCleaner.start
    assert_equal 0, Build.count, 'There should be no builds in the database.'
  end

  def teardown
    DatabaseCleaner.clean
    assert_equal 0, Build.count, 'There should be no builds in the database.'
  end

  test 'it must belong to a valid project' do
    build = Factory.build :build

    assert_kind_of Project, build.project, 'A build must belong to a project.'
    assert build.project.valid?, 'A build project is invalid.'
  end

  test 'it must have a last commit SHA-1' do
    build = Factory.build :build

    assert build.valid?
    build.last_commit = 'bad value'

    refute build.valid?, 'build should be invalid because the last commit SHA-1 is malformed.'
  end

  test 'it must belong to a valid last commiter' do
    build = Factory.build :build

    assert_kind_of User, build.last_commiter, 'The build must have a last commiter.'
    assert build.last_commiter.valid?, 'The build last commiter is invalid.'
  end

  test 'it must have a status which is true or false' do
    build = Factory.build :build

    assert [ true, false ].include? build.status
  end

  test 'it must add the last commiter as a collaborator on the project' do
    build = Factory.build :build

    assert_equal 1, build.project.users.count

    build.save

    assert_equal 2, build.project.users.count
  end


  # Failed builds cost one beer.

  test 'it must charge one beer to the last commiter of a failed build' do
    failed_build = Factory.build :failed_build

    assert_equal 0, failed_build.last_commiter.beers

    failed_build.save

    assert_equal 1, failed_build.last_commiter.beers
  end

end
