# TODO: Q: What about "after do ; @project.save ; end' to be sure the record always saves?
#          This would slow down the testsuite.

require "minitest_helper"

# TODO: Q: Why ::Rails::Model, instead of ::AR::Model?  Fixture glue is a railtie?
# TODO: Q: Why ::Rails::Model, instead of Minitest::Spec?  Fixture glue is a railtie?
class ProjectTest < MiniTest::Rails::Model

  before do
    # TODO: Use Factories here?
    @user =  User.new(:email => 'user@example.com', :password => 'password')
    @project = Project.new(:name => 'Test Project')
    @project.users << @user
  end

  it 'must have a name' do
    refute_empty @project.name, 'The project has no name.'
  end

  it 'should have an auto-generated url' do
    # In fact, we want the URL to be unique.. how to test that?
    # Should we be testing the algorithm too?  Or just that it's != null

    # A few ways to do this with Minitest's assertions/expectations
    # @project.url.wont_be_empty
    refute_empty @project.url, 'The project has no URL.'
  end

  # Really?
  # Should we implicitly make the project-creating-user a collaborator?
  # What about a user creating a project who is not a collaborator on THAT same project?
  it 'must have a user' do
    @project.users << @user
    refute_empty @project.users, 'The project has no users.'
  end

  # TODO: The following tests really need before/after setup/teardown to insure
  # TODO: objects are in the DB but are also properly removed at the end of the
  # TODO: testcase (to avoid leakage to other tests when randomized.
  # -----------------------------------------

  # TODO: Q: This feels wrong.  The testsuite is now dependent on the DB state.
  # TODO: Q: What if another test creates a Collaboration? :/
  it 'should delete collaborations when deleted' do

    # We must persist @project so that ActiveRecord will create the collaboration record.
    @user.save
    @project.save

    assert_equal(1, Collaboration.all.count, 'Project collaborators were not created.')

    @project.destroy
    assert_equal(0, Collaboration.all.count, 'Project collaborators were not destroyed.')

    @user.destroy
  end

  it 'should not delete users when deleted' do

    # Put a user and project in the DB.
    @user.save
    @project.save

    assert_equal(@user, User.find_by_email(@user.email))

    @project.destroy
    assert_equal(@user, User.find_by_email(@user.email))

    @user.destroy
  end

  # -----------------------------------------


  # it 'must have a unique url' do
  #   # TODO: A uniqueness test on the URL.
  #   # create a Project with a known URL -> use chronic to stick Time.now?  but
  #   # that's Project implementation specific.  it would be nice to hijack the
  #   # object and change the random URL generate.
  # end

end
