require 'minitest_helper'

# MiniTest::Rails::Model < MiniTest::Rails:Spec < ::MiniTest::Spec
class ProjectTest < MiniTest::Rails::Model

  before do
    DatabaseCleaner.start

    @user = Factory.build(:user,
                          :email => 'testuser@example.com')

    @project       = Factory.build(:project)
    @project.users << @user
  end

  after do
    DatabaseCleaner.clean
  end

  it 'must have a name' do
    refute_empty @project.name, 'The project has no name.'
  end

  it 'should have an auto-generated uuid' do
    # A few ways to do this with Minitest's assertions/expectations
    # @project.uuid.wont_be_empty
    refute_empty @project.uuid, 'The project has no UUID.'
  end

  it 'must have a user' do
    refute_empty @project.users, 'The project has no users.'
  end

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

end
