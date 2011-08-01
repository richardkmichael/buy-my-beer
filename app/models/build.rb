class Build < ActiveRecord::Base

  # TODO: Q: b = Build.new ; b.status = 'false'; b. status ---> false.
  # TODO: Q: How is rails doing this?
  validates :status, :inclusion => { :in => [true, false] }

  belongs_to :last_commiter, :class_name => 'User'

  # TODO: Destroy builds when a project is deleted.
  # TODO: Use :inverse_of ?
  belongs_to :project

  scope :passed, where(:status => true)
  scope :failed, where(:status => false)

end
