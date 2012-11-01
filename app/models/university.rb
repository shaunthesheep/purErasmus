class University < ActiveRecord::Base
	# Attributes
	#-----------
	attr_accessible :contact, :name_english, :name_original, :website

	# Associations
	#-------------
	belongs_to :citys
	has_many :pages, :through => :page_type_universitys # syntax?

end
