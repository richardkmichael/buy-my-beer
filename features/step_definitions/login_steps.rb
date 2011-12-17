# Refactor for:
#   - "I am (not) logged in.", "I should (not) see ...".
#   - login_view_steps.rb ?

When /^I am logged in$/ do
  @user = Factory :user
  assert_equal(1, User.count)

  visit '/users/sign_in'
  fill_in 'Email',    :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button 'Sign in'

  # TODO: assert() something here

end

When /^I am not logged in$/ do
  # There should be no users.
  assert_equal(0, User.count)

  # If this is necessary, there has been state leakage; but ensure it.
  visit '/users/sign_out'

  # TODO: assert() something here

end

Then /^I should be able to log in$/ do

  # If we have an existing Cucumber user, log in with it.
  if @user
    email    = @user.email
    password = @user.password
  else
    email    = 'testuser@localhost.localdomain'
    password = 'test1234'
  end

  # TODO: xpath values here, use the id attribute for now.
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
