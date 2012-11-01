class Topic < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :description, :title

	# Associations
	#-------------
	has_many :comments
end
