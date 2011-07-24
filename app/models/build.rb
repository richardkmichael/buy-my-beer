class Build < ActiveRecord::Base

  # TODO: Q: Will this re-write the users table?  We don't want to dupe "user"
  # TODO:    style info in a committers table.. and it would be
  # TODO:    convenient if seen committers were able to log in.
  has_one :last_commiter, :class_name => 'User'

  # TODO: Destroy builds when a project is deleted.
  belongs_to :project

  scope :passed, where(:status => true)
  scope :failed, where(:status => false)

end
