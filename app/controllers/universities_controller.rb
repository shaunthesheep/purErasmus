class UniversitiesController < ApplicationController

  def index
    @universities = University.all
  end

  def show
  	@university = University.find(params[:id]) 
  end

  def edit
  	@university = University.find(params[:id])
#  	if session[:id] != @user.id
#  		flash[:notice] = "Sorry, you can't edit this user"
#  		redirect_to :action => 'index'
#  	end
  end

  def new
    @university = University.new
  end

  def create
    @university = University.new(params[:university])
    if @university.save
      redirect_to :action => 'index'
    else 
      render :action => "new"
    end
  end

  def update
     @university = University.find(params[:id])
     if @university.update_attributes(params[:university])
        redirect_to :action => 'show', :id => @university
     else
        render :action => 'edit'
     end
  end

  def destroy
      @university = University.find(params[:id])
      @university.destroy
      redirect_to universities_path
  end

end
