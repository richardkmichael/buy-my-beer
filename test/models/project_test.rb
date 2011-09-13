require 'minitest_helper'

# MiniTest::Rails::Model < MiniTest::Rails:Spec < ::MiniTest::Spec
class ProjectTest < MiniTest::Rails::Model

  describe 'creation behaviour' do
    before do
      @project = Factory.build(:project)
    end

    it 'must have a name' do
      refute_empty @project.name, 'A project must have a name.'
    end

    it 'should have an auto-generated uuid' do
      refute_empty @project.uuid, 'A project must auto-generate a UUID.'
    end

    it 'must have a user' do
      refute_empty @project.users, 'A project must have at least one user.'
    end
  end

  # Tests involve persistence, and need different setup and teardown.
  describe 'delete behaviour' do
    before do
      DatabaseCleaner.start

      # @build = Factory.create(:build)
      # @project = @build.project

      @project = Factory.create(:project)
    end

    after do
      DatabaseCleaner.clean
    end

    # We need another test for projects which have builds (more collaborators).
    it 'should delete the project owner as a collaborator when deleted' do
      total_collaborations = Collaboration.all.count

      assert_equal 1, @project.users.count, 'Project collaborators were not created.'
      @project.destroy
      assert_equal total_collaborations - 1, Collaboration.all.count, 'Project collaborators were not destroyed.'
    end

    it 'should not delete users when deleted' do
      @project.destroy
      assert User.find(@project.users.first)
    end

    it 'should delete builds when deleted' do
      assert true
    end
  end

end
