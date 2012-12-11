class TopicsController < ApplicationController

	def index
 	    forum_id = params[:city_id]

        # If we have cityId, return only the topics for the specified city.
        if (forum_id)
            @topics = City.find(forum_id).topics
            @city = City.find(forum_id)
        # Otherwise, return all the topics.
        else
            @topics = Topics.all            
        end
	end
	
	def new
       @topic = Topic.new
       @city = City.find(params[:city_id])
 	end

    def create
        @topic = Topic.new(params[:topic])
        @topic.city = City.find(params[:city_id])
        if @topic.save
            redirect_to city_topics_url(params[:city_id]) 
        else
            render :action => "new"
        end
    end

    def show
        @topic = Topic.find(params[:id])
    end

    def edit
        @topic = Topics.find(params[:id])
    end
    def destroy
    end


end
