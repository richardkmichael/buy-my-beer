require "minitest_helper"

# TODO: Q: Why ::Rails::Model, instead of ::AR::Model?  Fixture glue is a railtie?
# TODO: Q: Why ::Rails::Model, instead of Minitest::Spec?  Fixture glue is a railtie?
class ProjectTest < MiniTest::Rails::Model

  before do
    # TODO: Use a Factory here?
    @project = Project.new(:name => 'Test Project')
    @project.users << User.new(:email => 'user@example.com')
  end

  # TODO: Q: How are these three tests different than just calling .valid? on @project above?

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

  it 'must have a user' do
    refute_empty @project.users, 'The project has no users.'
  end

  # it 'must have a unique url' do
  #   # TODO: A uniqueness test on the URL.
  #   # create a Project with a known URL -> use chronic to stick Time.now?  but
  #   # that's Project implementation specific.  it would be nice to hijack the
  #   # object and change the random URL generate.
  # end

end
