class UsersController < ApplicationController
#hola
  def index
    @users = User.all
  end

  def show
  	@user = User.find(params[:id]) 
  end

  def edit
  	@user = User.find(params[:id])
#  	if session[:id] != @user.id
#  		flash[:notice] = "Sorry, you can't edit this user"
#  		redirect_to :action => 'index'
#  	end
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

  def update
     @user = User.find(params[:id])
     if @user.update_attributes(params[:user])
        redirect_to :action => 'show', :id => @user
     else
        render :action => 'edit'
     end
  end

  def destroy
      User.find(params[:id]).destroy
      redirect_to :action => 'index'
   end
end
