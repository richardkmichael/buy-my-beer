class Project < ActiveRecord::Base

  # TODO: Q: Other name validations?  What matters? length?
  validates :name, :presence => true

  # TODO: Q: This validator breaks.  Why?
  # TODO: Q: How to make the URL attribute read-only?
  # validates :url, :uniqueness => true

  validates :users, :presence => true

  has_many :collaborations, :dependent => :destroy
  has_many :users, :through => :collaborations

  has_many :builds, :dependent => :destroy

  def initialize(attributes = nil, options = {})
    super(attributes, options)
    self[:url] = generate_random_url
  end

  private

  # Generate a unique URL from the current time and a random number.
  # Assumes we don't have > 1,000,000 requests per second.
  def generate_random_url
    Digest::SHA2.hexdigest("#{Time.now.utc}--#{rand(1000000)}")
  end

end
