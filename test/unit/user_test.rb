require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = Factory.build :user
  end

  test 'it must have an email address' do
    assert_respond_to @user, :email
  end

  test 'it must have a password' do
    assert_respond_to @user, :password
  end

  test 'it must have a password confirmation' do
    assert_respond_to @user, :password_confirmation
  end

  test 'it should initialize with 0 beers' do
    assert_equal @user.beers, 0
  end

  test 'it must maintain a non-negative count of beers' do
    @user.beers = -1
    refute @user.valid?, '@user should be invalid because @user.beers < 0'
  end

  test 'it must have a remember me preference' do
    assert_respond_to @user, :remember_me
  end

  test 'it must have collaborations' do
    assert_respond_to @user, :collaborations
  end

  test 'it must have projects' do
    assert_respond_to @user, :projects
  end

  test 'it must validate the email address' do
    @user.email = ''
    refute @user.valid?
  end

  test 'it must validate the password' do
    @user.password = ''
    refute @user.valid?
  end

  # There is also a OmniauthCallbacksController#github action tested elsewhere.
  test 'class must provide a callback for omniauth using github' do
    assert_respond_to User, :find_for_github_oauth
  end
end
