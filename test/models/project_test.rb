require "minitest_helper"

# TODO: Q: Why ::Rails::Model, instead of ::AR::Model?  Fixture glue is a railtie?
# TODO: Q: Why ::Rails::Model, instead of Minitest::Spec?  Fixture glue is a railtie?
class ProjectTest < MiniTest::Rails::Model
  before do
    @project = Project.new
  end

  it "must have a name" do
    @project.name = 'Test Project'
    @project.valid?.must_equal true
  end

  # In fact, we want the URL to be unique.. how to test that?
  # Should we be testing the algorithm too?  Or just that it's != null
  it "must be have a url" do

    # A few ways to do this with Minitest's assertions/expectations
    # @project.url.wont_be_empty
    refute_empty @project.url, "Project's URL is empty!"
  end

  # TODO: A uniqueness test on the URL.
  # it 'must have a unique url' do
  #   # create a Project with a known URL -> use chronic to stick Time.now?  but
  #   # that's Project implementation specific.  it would be nice to hijack the
  #   # object and change the random URL generate.
  # end

end
