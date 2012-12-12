class ForumController < ApplicationController

	#shows all countries 
	def index
		@countries = Country.all
	end

	def show
		@country = Country.find(params[:id])
		@user = retrieve_authenticated_user
	end

end
