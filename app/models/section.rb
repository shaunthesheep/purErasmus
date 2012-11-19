class Section < ActiveRecord::Base
	# Attributes
	#-----------
 	attr_accessible :title, :description

 	# Associations
 	#-------------
 	belongs_to :page
end
