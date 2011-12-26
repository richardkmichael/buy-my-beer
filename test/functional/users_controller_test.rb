require 'test_helper'
require 'awesome_print'

class UsersControllerTest < ActionController::TestCase

  # TODO: Need view tests somewhere, doesn't feel right here ; but:
  # render_views

  # Runs before each test.
  def setup

    # TODO: Should controller tests be touching the database?
    DatabaseCleaner.clean

    # .create because tests need objects to retrieve
    # @user = Factory.create :user
  end

  test 'it must get #show with the correct user' do
    @user = Factory.create :user
    get :show, :id => @user.id
    assert_response :success
    assert_equal assigns(:user), @user
  end

  test 'it must get #new with successful' do
    @user = Factory.create :user
    get :new
    assert_response :success
    # TODO: How to assert the controller does '@user = User.new'
    # assert_equal assigns(:user), @user
  end

  test 'it must create a new user given valid attributes' do

    # TODO: I originally used an @invalid_user, and "assigns(:invalid_user), etc.
    # @invalid_user = Factory.build :user
    @user = Factory.build :user

    # TODO: This should fail validation, there's no :password_confirmation => ... ??
    post :create, :user => { :email => @user.email, :password => @user.password }

    # TODO: This feels wrong, we should probably not be accessing the model.
    assert_equal 1, User.count

    assert_redirected_to user_path(assigns(:user))
    assert_equal 'Your account has been created.', flash[:notice]

  end

  test 'it must not create a new user given invalid attributes' do

    post :create, :user => { :email => 'bad@email@address', :password => '' }

    # TODO: Feels weird to expect HTTP 200 here.
    # TODO: But it's an app error, not an HTTP error - we render 'new'.
    assert_response :success

    # TODO: This feels wrong, we should probably not be accessing the model.
    assert_equal 0, User.count

    assert_equal 'There were errors creating your account.', flash[:notice]
  end

  test 'it must not create a new user given an existing user' do

    # TODO: I originally used an @invalid_user, and "assigns(:invalid_user), etc.
    # @invalid_user = Factory.build :user
    @user = Factory.build :user

    # TODO: This should fail validation, there's no :password_confirmation => ... ??
    post :create, :user => { :email => @user.email, :password => @user.password }

    # Create another user, this should not error, but it should not create a duplicate user.
    post :create, :user => { :email => @user.email, :password => @user.password }

    # TODO: This feels wrong, we should probably not be accessing the model.
    assert_equal 1, User.count

    assert_redirected_to user_path(assigns(:user))
    assert_equal 'Your account has been created.', flash[:notice]

  end

end
