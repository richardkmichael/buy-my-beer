class User < ActiveRecord::Base

  attr_accessible :email, :beers, :password, :password_confirmation, :remember_me

  has_many :collaborations
  has_many :projects, :through => :collaborations

  devise :database_authenticatable, # Encrypted DB passwords, for non-GitHub auth users.
         :registerable,             # Sign up.
         :rememberable,             # Remember the user in a cookie.
         :omniauthable,             # Omniauth for GitHub.
         :recoverable,              # Reset DB passwords, with email to user.
         :validatable               # Validations on :email and :password.

  # Devise auth method: find a user by email, or create a user if not found.
  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']

    if user = User.find_by_email(data['email'])
      user
    else
      password = Devise.friendly_token[0,20]
      User.create!(:email                 => data['email'],
                   :password              => password,
                   :password_confirmation => password)
    end
  end
end
