class Topic < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :title, :description

	# Associations
	#-------------
	belongs_to :user
	has_many :comments
end
