class Project < ActiveRecord::Base

  # TODO: Q: Other name validations?  What matters? length?
  validates :name, :presence => true

  # TODO: Q: This validator breaks.  Why?
  # TODO: Q: How to make the UUID attribute read-only?
  # validates :uuid, :uniqueness => true

  validates :users, :presence => true

  has_many :collaborations, :dependent => :destroy
  has_many :users, :through => :collaborations

  has_many :builds, :dependent => :destroy

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
