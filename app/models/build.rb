class Build < ActiveRecord::Base

  after_save :update_last_commiter_beer_count,
             :add_last_commiter_to_collaborations

  # See: ActiveRecord::ConnectionAdapters::Column (TRUE|FALSE)_VALUES.
  #      nil is not a FALSE value.  This is effectively :presence => true.
  validates :status, :inclusion => { :in => [true, false] }

  # Git SHA1 only.
  validates :last_commit, :format => /[a-z0-9]{40}/i

  validates :project, :presence => true
  belongs_to :project

  validates :last_commiter, :presence => true
  belongs_to :last_commiter, :class_name => 'User'

  scope :passed, where(:status => true)
  scope :failed, where(:status => false)

  def passed? ; status ; end
  def failed? ; not passed? ; end

  private

  def update_last_commiter_beer_count
    if failed?
      last_commiter.update_attribute(:beers, last_commiter.beers + 1)
    end
  end

  def add_last_commiter_to_collaborations
    # Could be done in the DB with a collaborations table
    # primary_key(proj_id, user_id), then rescue DB error here.
    # Then, just "self.project.users << last_commiter".
    self.project.users << last_commiter unless self.project.users.include? last_commiter
  end
end
