class CountriesController < ApplicationController

 def index
    @user = retrieve_authenticated_user
    @countries = Country.all
  end

  def show
    @user = retrieve_authenticated_user
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
      redirect_to country_path(@coutry)
    else 
      render :new
    end
  end

  def update
     @country = Country.find(params[:id])
     if @country.update_attributes(params[:country])
        redirect_to country_path(@country)
     else
        render :edit
     end
  end

  def destroy
      Country.find(params[:id]).destroy
      redirect_to countries_path
   end

end
