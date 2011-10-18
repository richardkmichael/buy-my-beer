require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    DatabaseCleaner.start

    # @build = Factory.create(:build)
    # @project = @build.project
    @project = Factory.create(:project)
  end

  def teardown
    DatabaseCleaner.clean
  end

  test 'must have a name' do
    refute_empty @project.name, 'A project must have a name.'
  end

  test 'should have an auto-generated uuid' do
    refute_empty @project.uuid, 'A project must auto-generate a UUID.'
  end

  test 'must have a user' do
    refute_empty @project.users, 'A project must have at least one user.'
  end

  # We need another test for projects which have builds (more collaborators).
  test 'should delete the project owner as a collaborator when deleted' do
    total_collaborations = Collaboration.all.count

    assert_equal 1, @project.users.count, 'Project collaborators were not created.'
    @project.destroy
    assert_equal total_collaborations - 1, Collaboration.all.count, 'Project collaborators were not destroyed.'
  end

  test 'should not delete users when deleted' do
    @project.destroy
    assert User.find(@project.users.first)
  end

  test 'should delete builds when deleted' do
    assert true
  end

end
