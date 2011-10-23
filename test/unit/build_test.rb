require 'test_helper'

class BuildTest < ActiveSupport::TestCase

  def setup
    DatabaseCleaner.start

    @user = Factory.build(:user,
                          :email => 'testuser@example.com')

    @build = Factory.build(:build,
                           :last_commiter => @user)

    @failed_build = Factory.build(:failed_build)
  end

  def teardown
    DatabaseCleaner.clean
  end

  test 'it must belong to a project' do
    assert @build.project, 'A build must belong to a project.'
  end

  test 'it must have a last commit SHA-1' do
    assert @build.valid?
    @build.last_commit = 'bad value'
    refute @build.valid?, '@build should be invalid because SHA-1 is malformed.'
  end

  test 'it must belong to the last commiter' do
    assert_equal 'testuser@example.com', @build.last_commiter.email, 'A build must belong to the last commiter.'
  end

  test 'it must have a status which is true or false' do
    assert [ true, false ].include? @build.status
  end

  test 'it must charge one beer to the last commiter of a failed build' do
    assert_equal 0, @failed_build.last_commiter.beers
    @failed_build.save
    assert_equal 1, @failed_build.last_commiter.beers
  end

  test 'it must add the last commiter as a collaborator on the project' do
    assert_equal 1, @failed_build.project.users.count
    @failed_build.save
    assert_equal 2, @failed_build.project.users.count
  end

end
