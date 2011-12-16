# Refactor for:
#   - "I am (not) logged in.", "I should (not) see ...".
#   - login_view_steps.rb ?

When /^I am logged in$/ do
  @user = Factory :user
  assert_equal(1, User.count)

  # This needs to write to the session ; having a user in the DB is not enough obviously.
end

When /^I am not logged in$/ do
  @user = nil
  assert_equal(0, User.count)
end

# Button 'commit' here is a strange name.
Then /^I should be able to log in$/ do

  # This step can be called following 'I am not logged in', which sets @user = nil.
  # Honour @user, or provide defaults.
  # @user.email    ||= 'testuser@localhost.localdomain'
  # @user.password ||= 'test1234'

  if @user
    email    = @user.email
    password = @user.password
  else
    email    = 'testuser@localhost.localdomain'
    password = 'test1234'
  end

  # Need xpath values here, use the id attribute for now.
  fill_in 'user_email',    :with => email
  fill_in 'user_password', :with => password
  click_button 'Sign in'
end

Then /^I should see the login form$/ do
  assert(page.has_field?('Email') && page.has_field?('Password'),
    'Login form is missing.')
end

Then /^I should not see the login form$/ do
  refute(page.has_field?('Email') || page.has_field?('Password'),
    'Login form should be missing.')
end
