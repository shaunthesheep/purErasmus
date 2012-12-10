class Topic < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :title, :description

	# Associations
	#-------------
	belongs_to :user
	belongs_to :city
	has_many :comments
end
