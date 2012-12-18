class TopicsController < ApplicationController
    before_filter :setup
    before_filter :retrieve_topic, :only => [:show, :edit, :update, :destroy]
    layout :page_layout

    # Before filter to detect the City/University, and display the appropriate layout.
    def setup
        @parent_tab = :forum
        city_id = params[:city_id]
        university_id = params[:university_id]

        if (city_id)
            @city = City.find(city_id)
        elsif (university_id)
            @university = University.find(university_id)
        else 
            redirect_to root_url
        end
    end

    # Before filter to retrieve the current topic.
    def retrieve_topic
        @topic = Topic.find(params[:id])
    end

    # Method to choose the layout to use.
    def page_layout
        @city ? "layouts/city_detail" : "layouts/university_detail"
    end

    # GET /cities/:city_id/topics
    # Action method to display a list of topics for a specific City.
	def index
        # If we have cityId, return only the topics for the specified city.
        if (@city)
            @topics = @city.topics
        # Otherwise, return all the topics.
        else
            @topics = Topics.all            
        end
	end

    # GET /cities/:city_id/topics/:topic_id
    # Action method to display a specific topic.
    def show
        @comment = Comment.new
    end

    # GET /cities/:city_id/topics/:topic_id/edit
    # Action method to display the "edit topic" form.
    def edit
    end
	
    # GET /cities/:city_id/topics/new
    # Action method to display the "create topic" form.
	def new
        if !@site_user
            flash[:notice] = "Sorry, you must be logged on to add topic"
            redirect_to "index"
        end
       @topic = Topic.new
 	end

    # POST /cities/:city_id/topics
    # Action method to send the topic creation form.
    def create
        @topic = Topic.new(params[:topic])

        @topic.city = @city
        @topic.user = @site_user

        if @topic.save
            redirect_to "#{city_topics_path(@city)}#topic#{@topic.id}"
        else
            render "new"
        end
    end

    # PUT /cities/:city_id/topics/:id
    # Action method to send the "edit topic" form.
    def update
    end

    # DELETE /cities/:city_id/topics/:id
    # Action method to delete a topic.
    def destroy
        @topic.destroy
        # TODO: Redirect.
    end

end
