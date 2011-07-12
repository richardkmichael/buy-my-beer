# TODO: validators

class User < ActiveRecord::Base

  has_many :collaborations
  has_many :projects, :through => :collaborations

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable

  # Devise modules.
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Devise authentication method.
  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']

    # Debugging.
    # data.each_pair do |k,v|
    #   puts "data/user_hash: #{k} = #{v}"
    # end

    # Retreive existing user based on their GitHub email address.
    # TODO: Handle user changing GitHub email address; our stub account will not be found.
    if user = User.find_by_email(data['email'])
      user

    # Create a stub user if they don't exist.
    else
      password = Devise.friendly_token[0,20]
      # TODO: A trigger here, to alert the user we've created an account for them.
      # TODO: Fire an email if there's an address?  Display a notification in the view?  What about API?
      # FIXME: If the user has no email, this will fail.
      User.create!(:email                 => data['email'],
                   :password              => password,
                   :password_confirmation => password)
    end
  end

end
