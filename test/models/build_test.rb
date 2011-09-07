require 'minitest_helper'

class BuildTest < MiniTest::Rails::Model

  describe 'creation behaviour' do
    before do
      @user = Factory.build(:user,
                            :email => 'testuser@example.com')

      @build = Factory.build(:build,
                             :last_commiter => @user,
                             :last_commit   => '000000')
    end

    it 'must belong to a project' do
      assert @build.project, 'A build must belong to a project.'
    end

    it 'must have a last commit' do
      assert_equal '000000', @build.last_commit, 'A build must have a last commit.'
    end

    it 'must belong to the last commiter' do
      assert_equal 'testuser@example.com', @build.last_commiter.email, 'A build must belong to the last commiter.'
    end

    it 'must have a status which is true or false' do
      assert [ true, false ].include? @build.status
    end

    it 'must create a new user if the last commiter is not already a user' do
      assert false
    end

    it 'must add the last commiter as a collaborator on the project' do
      assert false
    end
  end

  # Tests involve persistence, and need different setup and teardown.
  describe 'model callbacks' do
    before do
      DatabaseCleaner.start
      @build = Factory.build(:failed_build)
    end

    after do
      DatabaseCleaner.clean
    end

    it 'must charge one beer to the last commiter of a failed build' do
      assert_equal 0, @build.last_commiter.beers
      @build.save
      assert_equal 1, @build.last_commiter.beers
    end
  end

end
