Then /^I should see the login form$/ do
  assert(page.has_field?('Email') || page.has_field?('Password'),
    'Login form should be missing.')
end

Then /^I should not see the login form$/ do
  refute(page.has_field?('Email') || page.has_field?('Password'),
    'Login form should be missing.')
end

# TODO: Refactor to this...
# Then /^I should( not)? see the login form$/ do |negative|
#   msg = "The login form should #{refute} be visible."

#   function = negative ? :refute : :assert

#   # TODO: The operator would need to change too.
#   self.__send__(function, (page.has_field?('Email') && page.has_field?('Password')), msg)
# end
