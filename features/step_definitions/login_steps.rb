# Refactor for:
#   - "I am (not) logged in.", "I should (not) see ...".
#   - login_view_steps.rb ?

When /^I am logged in$/ do
  @user = Factory :user
  assert_equal(1, User.count)
end
When /^I am not logged in$/ do
  @user = nil
  assert_equal(0, User.count)
end


Then /^I should see the login form$/ do
  assert(page.has_field?('Email') && page.has_field?('Password'),
    'Login form is missing.')
end

Then /^I should not see the login form$/ do
  refute(page.has_field?('Email') || page.has_field?('Password'),
    'Login form should be missing.')
end
