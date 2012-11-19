class City < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :title, :body # name, description

	# Associations 
	#-------------
	belongs_to :country
	has_many :pages
	has_many :universities
	has_many :topics
end
