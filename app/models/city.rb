class City < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :title, :body

	# Associations 
	#-------------
	has_many :pages, :through => :page_type_citys # syntax?
	has_many :universitys
	has_many :topics
end
