require "minitest_helper"

class ProjectControllerTest < MiniTest::Rails::Controller
  before do
    @controller = ProjectController.new
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
