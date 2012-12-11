class ForumController < ApplicationController

	#shows all countries 
	def index
		@countries = Country.all
	end

	def show
		@country = Country.find(params[:id])
	end

end
