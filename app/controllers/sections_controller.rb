class SectionsController < ApplicationController
  
  #def index
  #  @sections = Section.all
  #end
  
  def edit
  	@section = Section.find(params[:section_id])
#  	if session[:id] != @user.id
#  		flash[:notice] = "Sorry, you can't edit this user"
#  		redirect_to :action => 'index'
#  	end
  end

  def new 
      page_id = params[:page_id]

      page = Page.find(page_id)
      @section = Section.new
      @section.page = page
      @section.save

  end

  def create
    @section = Section.new(params[:section])
    if @section.save
      if @section.page.city
        redirect_to city_page_path(@section.page.city, @section.page)
      end
      if @section.page.university
        redirect_to university_page_path(@section.page.university, @section.page)
      end
    else 
      render :action => "new"
    end
  end

  def update
     @section = Section.find(params[:id])
     if @section.update_attributes(params[:section])
      if @section.page.city
        redirect_to city_page_path(@section.page.city, @section.page)
      end
      if @section.page.university
        redirect_to university_page_path(@section.page.university, @section.page)
      end
     else
        render :action => 'edit'
     end
  end

  def destroy
    section = Section.find(params[:id])
    if section.page.university
      university = section.page.university
      section.destroy
      redirect_to university_path(university)
    end
    if section.page.city
      city = section.page.city
      section.destroy
      redirect_to city_path(city)
    end
   end

end
