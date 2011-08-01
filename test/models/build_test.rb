# TODO: Refactor the 'before do' -> fixtures?
# TODO: Remove magic strings.

require "minitest_helper"

class BuildTest < MiniTest::Rails::Model

  before do
    @user = User.new(:email => 'testuser@example.com', :password => 'password')
    @project = Project.new(:name => 'Test Project')
    @project.users << @user

    @build = Build.new(:name => 'Test Suite Build',
                       :last_commit => '000000',
                       :last_commiter => @user,
                       :status => true,
                       :project => @project)

  end

  # TODO: Q: Is 'nil' the correct value to test for?
  it 'must belong to a project' do
    refute_nil @build.project, 'The build has no project.'
  end

  it 'must have a last commit' do
    assert_equal '000000', @build.last_commit, 'The build has no last commit.'
  end

  it 'must belong to the last commiter' do
    assert_equal 'testuser@example.com', @build.last_commiter.email, 'The build does not belong to the correct last commiter.'
  end

  # TODO: How to test true OR false?  We need to change the status.  Is this really an integration test?
  it 'must have a status which is true or false' do
    assert @build.status
  end

end
