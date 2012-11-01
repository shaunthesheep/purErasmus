class Comment < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :description

	# Associations
	#-------------
	belongs_to :topic
	belongs_to :user
end
