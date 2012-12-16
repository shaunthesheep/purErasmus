class CitiesController < ApplicationController

    # GET /cities
    # GET /countries/:country_id/cities
    # Action method to retrieve a list of cities. Can be returned in multiple formats.
    def index
        @user = retrieve_authenticated_user
        country_id = params[:country_id]

        # If we have countryId, return only the cities for the specified country.
        if (country_id)
            @cities = Country.find(country_id).cities
        # Otherwise, return all the cities.
        else
            @cities = City.all            
        end

        # Decide on the return format.
        respond_to do |format|
            format.json { render :json  => @cities }
        end
    end

    def show
        @city = City.find(params[:id])
        @user = retrieve_authenticated_user
        page_id = params[:page_id]
        if (page_id)
            @page = Page.find(page_id)
        else
            @page = @city.pages.first
        end
    end

    def edit
        @city = City.find(params[:id])
        @countries = Country.all.map { |country| [country.name, country.id] }
    end

    def new
        @city = City.new
        @countries = Country.all.map { |country| [country.name, country.id] }
    end

    def create
        @city = City.new(params[:city])
        if @city.save
            redirect_to city_path(@city)
        else 
            render "new"
        end
    end

    def update
        @city = City.find(params[:id])
        if @city.update_attributes(params[:city])
            redirect_to city_path(@city)
        else
            render "edit"
        end
    end

    def destroy
        City.find(params[:id]).destroy
        redirect_to cities_path
    end
end
