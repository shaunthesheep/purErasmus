class CountriesController < ApplicationController

 def index
    @countries = Country.all
  end

  def show
  	@country = Country.find(params[:id])
  end

  def edit
  	@country = Country.find(params[:id])
#  	if session[:id] != @user.id
#  		flash[:notice] = "Sorry, you can't edit this user"
#  		redirect_to :action => 'index'
#  	end
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(params[:country])
    if @country.save
      redirect_to :action => "index"
    else 
      render :action => "new"
    end
  end

  def update
     @country = Country.find(params[:id])
     if @country.update_attributes(params[:country])
        redirect_to :action => 'show', :id => @country
     else
        render :action => 'edit'
     end
  end

  def destroy
      Country.find(params[:id]).destroy
      redirect_to :action => 'index'
   end

end
