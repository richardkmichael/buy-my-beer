require "minitest_helper"

class ProjectsControllerTest < MiniTest::Rails::Controller

  before do
    @controller = ProjectsController.new
  end

  it 'must respond to get' do
    response = get :index
    puts response
  end
end
