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

    def create
        @topic = Topic.new(params[:topic])
        if @topic.save
            render :action => "index"
            #redirect_to root_url
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
