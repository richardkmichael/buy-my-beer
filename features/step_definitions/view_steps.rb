When /^I should be told '(.*)'$/ do |message|
  assert page.has_content? message
end

When /^I should not be told '(.*)'$/ do |message|
  refute page.has_content? message
end
