# Build specially named factories?  :successful_build, etc.?
# Inherited factories or callbacks might handle the nested factories.

Factory.define(:user) do |u|
  u.sequence(:email) { |n| "test-email-#{n}@example.com" }
  u.password "testpass"
  u.beers 0
end

Factory.define(:project) do |p|
  p.sequence(:name) { |n| "Test Project #{n}" }
  # How to add this attribute?  It is required for validation.
  # p.users
end

Factory.define(:build) do |b|
  b.status true
  b.sequence(:last_commit) { |n| Digest::SHA1.hexdigest "commit-#{n}" }
  # How to add this attribute?  It is required for validation.
  # b.project
  # p.last_commiter
end
