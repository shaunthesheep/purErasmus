require "bcrypt"

class User < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :email, :first_name, :last_name, :password

	# Associations
	#-------------
	has_many :comments
	has_many :topics
	has_one :admin_university, :class_name => "University"
	belongs_to :home_university, :class_name => "University"
	belongs_to :foreign_university, :class_name => "University"
	belongs_to :user_type, :class_name => "UserType"
	
	# Validations
	#------------
	validates :email, :presence => true, :format => { :with => /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/ }
	validates :first_name, :presence => true
	validates :last_name, :presence => true	
end
