class Build < ActiveRecord::Base

  after_save :update_last_commiter_beer_count

  # See: ActiveRecord::ConnectionAdapters::Column (TRUE|FALSE)_VALUES.
  #      nil is not a FALSE value.  This is effectively :presence => true.
  validates :status, :inclusion => { :in => [true, false] }

  validates :last_commit, :presence => true

  validates :project, :presence => true
  belongs_to :project

  validates :last_commiter, :presence => true
  belongs_to :last_commiter, :class_name => 'User'
             # :autosave => true # Except we don't want to re-save existing records. :/

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
end
