require "minitest_helper"

class BuildTest < MiniTest::Rails::Model

  before do
    DatabaseCleaner.start

    @user =  User.new(:email    => 'testuser@example.com',
                      :password => 'password',
                      :beers    => 0)

    @project       =  Project.new(:name => 'Test Project')
    @project.users << @user

    @build = Build.new(:name          => 'Test Suite Build',
                       :last_commit   => '000000',
                       :last_commiter => @user,
                       :status        => true,
                       :project       => @project)
  end

  after do
    DatabaseCleaner.clean
  end

  it 'must belong to a project' do
    refute_nil @build.project, 'The build has no project.'
  end

  it 'must have a last commit' do
    assert_equal '000000', @build.last_commit, 'The build has no last commit.'
  end

  it 'must belong to the last commiter' do
    assert_equal 'testuser@example.com', @build.last_commiter.email, 'The build does not belong to the correct last commiter.'
  end

  it 'must have a status which is true or false' do
    assert @build.status
  end

  it 'must charge one beer to the last commiter when saved and the build failed' do
    assert_equal 0, @build.last_commiter.beers
    @build.status = false
    @build.save
    assert_equal 1, @build.last_commiter.beers
  end

end
