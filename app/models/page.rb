class Page < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :title, :body, :university_id

 	# Associations
 	#-------------
 	belongs_to :city
 	belongs_to :university
 	belongs_to :page_type

 	has_many :sections
end
