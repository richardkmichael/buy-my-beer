require "minitest_helper"

class ProjectHelperTest < MiniTest::Rails::Helper
  before do
    @helper= ProjectHelper.new
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
