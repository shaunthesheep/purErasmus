class City < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :name, :description, :country_id

	# Associations 
	#-------------
	belongs_to :country
	has_many :pages
	has_many :universities
	has_many :topics
end
