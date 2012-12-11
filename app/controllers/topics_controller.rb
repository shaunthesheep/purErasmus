class TopicsController < ApplicationController

	def index
 	    forum_id = params[:city_id]

        # If we have cityId, return only the topics for the specified city.
        if (forum_id)
            @topics = City.find(forum_id).topics
        # Otherwise, return all the topics.
        else
            @topics = Topics.all            
        end
	end
	
	def new
        @topic = Topic.new
	end


end
