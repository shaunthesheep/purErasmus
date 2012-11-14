class Topic < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :description, :title

	# Associations
	#-------------
	belongs_to :user
	has_many :comments
end
