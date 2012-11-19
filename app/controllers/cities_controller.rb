class CitiesController < ApplicationController

  def index
    @cities = City.all
  end

  def show
  	@city = City.find(params[:id]) 
  end

  def edit
  	@city = City.find(params[:id])
#  	if session[:id] != @user.id
#  		flash[:notice] = "Sorry, you can't edit this user"
#  		redirect_to :action => 'index'
#  	end
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(params[:city])
    if @city.save
      redirect_to :action => "index"
    else 
      render :action => "new"
    end
  end

  def update
     @city = City.find(params[:id])
     if @city.update_attributes(params[:city])
        redirect_to :action => 'show', :id => @city
     else
        render :action => 'edit'
     end
  end

  def destroy
      City.find(params[:id]).destroy
      redirect_to :action => 'index'
   end
end
