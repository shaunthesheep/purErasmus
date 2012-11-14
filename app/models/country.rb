class Country < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :name

	# Associations
	#-------------
	has_many :cities
end
