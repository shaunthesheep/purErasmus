class University < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :contact, :name_english, :name_original, :website

	# Associations
	#-------------
	belongs_to :city
	has_many :pages, :through => :page_type_universitys # syntax?

end
