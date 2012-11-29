class UniversitiesController < ApplicationController

    # GET /universities
    # GET /countries/:country_id/universities
    # Action method to retrieve a list of universities. Can be returned in multiple formats.
    def index
        country_id = params[:country_id]

        # If we have a countryId, return only the universities for the specified country.
        if (country_id)
            @universities = Country.find(country_id).cities.map { |city| city.universities }.flatten
        # Otherwise, return all universities.
        else
            @universities = University.all
        end

        # Decide on the return format.
        respond_to do |format|
            format.json { render :json => @universities }
        end
    end

    def show
        @university = University.find(params[:id]) 
    end

    def edit
        @university = University.find(params[:id])
        @cities = City.all.map { |city| [city.name, city.id] }
    end

    def new
        @university = University.new
        @cities = City.all.map { |city| [city.name, city.id] }
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
