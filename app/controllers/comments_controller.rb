class CommentsController < ApplicationController

  #def new
  #  @comment = Comment.new
  #  @topic = Topic.find(params[:id])
  #end

  def create
    topic = Topic.find(params[:topic_id])
    @comment = Comment.new(params[:comment])
    @comment.topic = topic
    @comment.user = retrieve_authenticated_user
    if @comment.save
      redirect_to "#{city_topic_path(topic.city, topic)}#comment#{@comment.id}" 
    else 
      render "new"
    end
  end


end
