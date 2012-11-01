class Page < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :title, :body

 	# Associations
 	#-------------
 	has_many :sections
end
