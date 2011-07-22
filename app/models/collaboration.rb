class Collaboration < ActiveRecord::Base

  belongs_to :user
  belongs_to :project  # NOTE: Project has :dependent => :destroy to remove collabs on non-existent projects.

end
