class Section < ActiveRecord::Base
	# Attributes
	#-----------
 	attr_accessible :description, :title

 	# Associations
 	#-------------
 	belongs_to :page
end
