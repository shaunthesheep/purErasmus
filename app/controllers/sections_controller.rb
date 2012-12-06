class SectionsController < ApplicationController

  def index
    @sections = Section.all
  end
  
  def edit
  	@section = Section.find(params[:id])
#  	if session[:id] != @user.id
#  		flash[:notice] = "Sorry, you can't edit this user"
#  		redirect_to :action => 'index'
#  	end
  end

  def new #(university)
  	@section = Section.new
  	#@page.university = university
   end

  def create
    @section = Section.new(params[:section])
    if @section.save
      redirect_to root_url
    else 
      render :action => "new"
    end
  end

  def update
     @section = Section.find(params[:id])
     if @section.update_attributes(params[:section])
        redirect_to root_url
     else
        render :action => 'edit'
     end
  end

  def destroy
      Section.find(params[:id]).destroy
      redirect_to :action => 'index'
   end

end
