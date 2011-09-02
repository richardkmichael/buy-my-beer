class User < ActiveRecord::Base

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :collaborations
  has_many :projects, :through => :collaborations

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable

  # Devise modules.
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Devise authentication method.
  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']

    # Retreive existing user based on their GitHub email address.
    if user = User.find_by_email(data['email'])
      user

    # Create a stub user if they don't exist.
    else
      password = Devise.friendly_token[0,20]
      User.create!(:email                 => data['email'],
                   :password              => password,
                   :password_confirmation => password)
    end
  end

end
