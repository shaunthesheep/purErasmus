class PagesController < ApplicationController

  #def index
  #  @pages = Page.all
  #end
  
  def edit
  	@page = Page.find(params[:page_id])
#  	if session[:id] != @user.id
#  		flash[:notice] = "Sorry, you can't edit this user"
#  		redirect_to :action => 'index'
#  	end
  end

  def new
    if (:id)
      university_id = params[:id]
    end
    if (:city_id)
      city_id = params[:city_id]
    end
    

    if (university_id)
      university = University.find(university_id)
      @page = Page.new
      @page.university = university
      @page.save
    else
      @page = Page.new
    end

    if (city_id)
      city = City.find(city_id)
      @page = Page.new
      @page.city = city
      @page.save
    else
      @page = Page.new
    end
  	
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      if @page.city
        redirect_to city_page_path(@page.city, @page)
      end
      if @page.university
        redirect_to university_page_path(@page.university, @page)
      end
    else 
      render :action => "new"
    end
  end

  def update
     @page = Page.find(params[:id])
     if @page.update_attributes(params[:page])
        if @page.city
          redirect_to city_page_path(@page.city, @page)
        end
        if @page.university
          redirect_to university_page_path(@page.university, @page)
        end
     else
        render :action => 'edit'
     end
  end

  def destroy
    page = Page.find(params[:id])
    if page.university
      university = page.university
      page.destroy
      redirect_to university_path(university)
    end
    if page.city
      city = page.city
      page.destroy
      redirect_to city_path(city)
    end
   end

end
