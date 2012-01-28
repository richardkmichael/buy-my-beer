class User < ActiveRecord::Base

  # A virtual attribute.
  attr_accessor :password

  # Protect against mass-assignment.
  attr_accessible :email, :beers, :password, :password_confirmation

  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 8..40 }

  before_save :encrypt_password


  validates :beers, :presence     => true,
                    :numericality => { :only_integer => true,
                                       :greater_than_or_equal_to => 0 }

  # Email uniqueness needs a database constraint as well, because multiple simultaneous requests
  # only in memory (not yet saved) will both pass validation ; race condition.
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format   => { :with => email_regex }

  has_many :collaborations
  has_many :projects, :through => :collaborations

  def has_password?(submitted_password)
    encrypt(submitted_password) == self.encrypted_password
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.has_password?(password)
      user
    else
      nil
    end
  end

  private

  def encrypt_password
    # Called on every .save(), so don't generate a new salt if we have one.
    self.salt =  make_salt unless has_password?(password)
    self.encrypted_password = encrypt(self.password)
  end

  def encrypt(password)
    secure_hash("#{self.salt}--#{password}")
  end

  def make_salt
    secure_hash(Time.now.utc.to_s)
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
