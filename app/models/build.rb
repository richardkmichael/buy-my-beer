class Build < ActiveRecord::Base

  # See: ActiveRecord::ConnectionAdapters::Column (TRUE|FALSE)_VALUES.
  validates :status, :inclusion => { :in => [true, false] }

  validates :project, :presence => true

  # TODO: Validate the format (SHA1) of the commit?  Assumes we're always git.
  validates :last_commit, :presence => true

  belongs_to :last_commiter, :class_name => 'User'

  belongs_to :project

  scope :passed, where(:status => true)
  scope :failed, where(:status => false)

end
