class Project < ActiveRecord::Base

  validates :name, :presence => true

  validates :users, :presence => true

  has_many :collaborations, :dependent => :destroy
  has_many :users, :through => :collaborations

  has_many :builds, :dependent => :destroy

  # This is not the Rails Way(tm).  Except I don't like binding model
  # logic to persistence with hooks. :/
  # TODO: Possibly fix with after_initialize() ; if new? ... ; end
  #       See the Rails 3 Way, page 308.  It's called after each DB load. :/
  def initialize(attributes = nil, options = {})
    super(attributes, options)
    self[:uuid] = generate_uuid
  end

  private

  # Generate a UUID from the current time and a random number.
  # Assumes we don't have > 1,000,000 requests per second.
  def generate_uuid
    Digest::SHA2.hexdigest("#{Time.now.utc}--#{rand(1000000)}")
  end

end
