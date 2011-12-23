require 'factory_girl'

FactoryGirl.define do

  sequence :commit do |n|
    Digest::SHA1.hexdigest "commit-#{n}"
  end

  sequence :email do |n|
    "test-email-#{n}@example.com"
  end

  factory :user, :aliases => [:last_commiter] do
    email { FactoryGirl.generate :email }
    password 'testpass'
    beers 0
  end

  # Create a project with an owning user.
  factory :project do
    users { FactoryGirl.build_list(:user, 1) }
    sequence(:name) { |n| "Test Project #{n}" }

    # This factory is broken.  It will create two projects (the build itself will create a second one.)
    factory :project_with_build do
      builds { FactoryGirl.build_list(:build, 1) }
    end
  end

  # Create a build with a commit, last committer and belonging to a project
  # (project factory has an owning user).  Thus, this factory creates two
  # users.
  factory :build do

    project
    status true
    last_commiter
    last_commit { FactoryGirl.generate :commit }

    factory :failed_build do
      status false
    end
  end

end


# Examples
#
# Factory.define do
#   factory :user do
#     given_name 'Richard'
#     famiy_name 'Michael'
#   end
# end

# Factory.define(:user) do
#   given_name 'Richard'
#   famiy_name 'Michael'
# end

# Factory.define do
#   sequence :email do |n|
#     "test-email-#{n}@example.com"
#   end
# end
