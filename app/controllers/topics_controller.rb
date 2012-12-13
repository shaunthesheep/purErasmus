class TopicsController < ApplicationController

	def index
 	    forum_id = params[:city_id]
        @user = retrieve_authenticated_user
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
        @topic.user = retrieve_authenticated_user
        if @topic.save
            redirect_to root_url
        else
            render :action => "new"
        end
    end

    def show
        @city = City.find(params[:city_id])
        @user = retrieve_authenticated_user
        @topic = Topic.find(params[:id])
        @comment = Comment.new
    end

    def edit
        @topic = Topic.find(params[:id])
    end
    def destroy
    end


end
