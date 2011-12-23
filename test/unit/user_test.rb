require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # Runs before each test.
  def setup
    # .create because some model attributes are computed with :before_save().
    @user = Factory.create :user
  end

  test 'it must create a new instance given valid attributes' do
    attributes = { :email                 => 'testuser@example.org',
                   :password              => 'test1234',
                   :password_confirmation => 'test1234',
                   :beers                 => 5 }

    u = User.create(attributes)
    assert u.valid?
  end

  # Email attribute tests
  test 'it must require an email address' do
    assert_respond_to @user, :email
    @user.email = ''
    refute @user.valid?, 'User requires an email address'
  end

  test 'it must validate the email address format' do
    @user.email = 'badly@formed@emailaddress'
    refute @user.valid?, 'User email address must be properly formed.'
  end

  # Password attribute tests
  test 'it must require a password' do
    assert_respond_to @user, :password
    @user.password = ''
    refute @user.valid?, 'User requires a password'
  end

  test 'it must have a password confirmation' do
    assert_respond_to @user, :password_confirmation,
      'User should have a password confirmation attribute'
  end

  test 'it must have an encrypted password' do
    assert_respond_to @user, :encrypted_password
      'User should have an encrypted password attribute'
  end

  test 'it must have a non-empty encrypted password' do
    refute_empty @user.encrypted_password
  end

  test 'it must respond to has_password?' do
    assert_respond_to @user, :has_password?
  end

  test 'it must return true when the provided and encrypted passwords match' do
    assert @user.has_password?(@user.password)
  end

  test 'it must return false when the provided and encrypted passwords do not match' do
    refute @user.has_password?(@user.password * 2)
  end

  test 'it must reject short passwords' do
    # TODO: Generate a random string < password length.
    @user.password = 'short'
    refute @user.valid?, 'User requires a password of minimum 8 characters'
  end

  test 'it must reject long passwords' do
    # TODO: Generate a random string > password length.
    @user.password = 'a' * 41
    refute @user.valid?, 'User requires a password of maximum 40 characters'
  end

  # Authentication tests
  test 'it must return nil on email / password mismatch' do
    assert_nil User.authenticate(@user.email, 'incorrect_password')
  end

  test 'it must return nil for an email with no user account' do
    assert_nil User.authenticate('random@example.com', @user.password)
  end

  # Beer attribute tests
  test 'it should initialize with 0 beers' do
    assert_equal @user.beers, 0
  end

  test 'it must maintain a non-negative count of beers' do
    @user.beers = -1
    refute @user.valid?, '@user should be invalid because @user.beers < 0'
  end

  # Relationship tests
  test 'it must have collaborations' do
    assert_respond_to @user, :collaborations
  end

  test 'it must have projects' do
    assert_respond_to @user, :projects
  end

  # Remember me tests
  # test 'it must have a remember me preference' do
  #   assert_respond_to @user, :remember_me
  # end

  # There is also a OmniauthCallbacksController#github action tested elsewhere.
  # test 'class must provide a callback for omniauth using github' do
  #   assert_respond_to User, :find_for_github_oauth
  # end
end
