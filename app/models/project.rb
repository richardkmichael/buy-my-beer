class Project < ActiveRecord::Base

  attr_accessible :name

  # TODO: Do we need other validations?  What matters?  Length?
  validates :name, :presence => true

  has_many :success_builds, :class_name => 'Build',
                            :conditions => { :status => true }

  has_many :failed_builds, :class_name => 'Build',
                           :conditions => { :status => false }

  has_many :collaborations
  has_many :users, :through => :collaborations

end
