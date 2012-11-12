class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  	@user = User.find(params[:id]) 
  end

  def edit
  	@user = User.find(params[:id])
  	if session[:id] != @user.id
  		flash[:notice] = "Sorry, you can't edit this user"
  		redirect_to users_path
  	end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url
    else 
      render :action => "new"
    end
  end
end
