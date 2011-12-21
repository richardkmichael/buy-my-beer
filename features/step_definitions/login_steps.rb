When /^I log in( again)?|I am logged in$/ do |again|
  # If this step runs more than once per-scenario, don't create a second user.
  @user ||= Factory :user
  assert_equal(1, User.count)

  visit '/users/sign_in'
  fill_in 'Email',    :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button 'Sign in'

  # Refuting a magic string is bad, but devise gives back a 200 even on auth
  # failure ; what else to assert or refute?
  refute page.has_content?('Invalid username or password.'), 'Login should not have failed.'
end

When /^I log out|I am not logged in$/ do
  # If this is necessary, there has been state leakage; but ensure it.
  visit '/users/sign_out'

  # TODO: assert() something here
end

Given /^I have never logged in/ do
  # If no one has logged in, there should be no users.
  assert_equal 0, User.count
end
