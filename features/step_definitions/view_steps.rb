When /^I visit '(.*)'$/ do |path|
  # visit() only takes the path (what is lib/capybara/rack_test/browser.rb
  # How do I visit the URL with the user in the session?
  visit(path, @user)
end
