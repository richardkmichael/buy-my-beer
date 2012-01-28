# TODO: Why don't validations without :password_confirmation fail?
# TODO: How to assert the controller does 'user = User.new'
#       assert_equal assigns(:user), @user

require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  # render_views

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end


  # Creation tests.

  test 'it must get #show with the correct user' do
    user = Factory.create :user
    get :show, :id => user.id
    assert_response :success
    assert_equal assigns(:user), user
  end

  test 'it must show a form to create a user' do
    get :new
    assert_response :success
  end

  test 'it must create a new user given valid attributes' do

    user = Factory.build :user

    post :create, :user => { :email => user.email, :password => user.password }

    assert_equal 1, User.count
    assert_redirected_to user_path(assigns(:user))
    assert_equal 'Your account has been created.', flash[:notice]

  end

  test 'it must not create a new user given invalid attributes' do

    post :create, :user => { :email => 'bad@email@address', :password => '' }

    assert_response :success
    assert_equal 0, User.count
    assert_equal 'There were errors creating your account.', flash[:notice]
  end



  # Authentication tests.

  test 'it must authenticate (not create) given an existing username and password' do

    user = Factory.build :user

    post :create, :user => { :email => user.email, :password => user.password }
    post :create, :user => { :email => user.email, :password => user.password }

    assert_equal 1, User.count
    assert_redirected_to user_path(assigns(:user))
    assert_equal 'Welcome back!', flash[:notice]

  end

  test 'it must not authenticate (and not create) given an existing username and bad password' do

    user = Factory.create :user

    post :create, :user => { :email => user.email, :password => 'badpassword'}

    assert_equal 1, User.count
    assert_equal 'Incorrect password.', flash[:notice]
  end

end
