class PagesController < ApplicationController

  def index
    @pages = Page.all
  end
  
  def edit
  	@page = Page.find(params[:id])
#  	if session[:id] != @user.id
#  		flash[:notice] = "Sorry, you can't edit this user"
#  		redirect_to :action => 'index'
#  	end
  end

  def new #(university)
  	@page = Page.new
  	#@page.university = university
   end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to root_url
    else 
      render :action => "new"
    end
  end

  def update
     @page = Page.find(params[:id])
     if @page.update_attributes(params[:page])
        redirect_to root_url
     else
        render :action => 'edit'
     end
  end

  def destroy
      Page.find(params[:id]).destroy
      redirect_to :action => 'index'
   end

end
