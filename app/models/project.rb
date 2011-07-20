class Project < ActiveRecord::Base

  def initialize(attributes = nil, options = {})
    super(attributes, options)
    self[:url] = generate_random_url
  end

  # TODO: Q: How to insure :url is read only?
  attr_accessible :name, :url

  # TODO: Q: Do we need other validations?  What matters?  Name length?
  validates :name, :presence => true

  # TODO: Q: This validator breaks.  Why?
  # validates :url, :uniqueness => true

  has_many :success_builds, :class_name => 'Build',
                            :conditions => { :status => true }

  has_many :failed_builds, :class_name => 'Build',
                           :conditions => { :status => false }

  has_many :collaborations
  has_many :users, :through => :collaborations


  private

  # Generate a unique URL from the current time and a random number.
  # Assumes we don't have > 1,000,000 requests per second.
  def generate_random_url
    Digest::SHA2.hexdigest("#{Time.now.utc}--#{rand(1000000)}")
  end

end
