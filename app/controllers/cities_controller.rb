class CitiesController < ApplicationController
    before_filter :city_layout_setup
    before_filter :retrieve_city, :only => [:show, :edit, :update, :destroy]
    before_filter :retrieve_countries, :only => [:new, :create, :edit, :update]

    # This filter is used to set the selected tab.
    def city_layout_setup
        @tab = :city
    end

    # This filter retrieves a city from its Id.
    def retrieve_city
        @city = City.find(params[:id])         
    end

    # This filter retrieves a list of countries for the "edit city" form.
    def retrieve_countries
        @countries = Country.all.map { |country| [country.name, country.id] }        
    end

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
        #respond_to do |format|
        #    format.json { render :json  => @cities }
        #end
    end

    # GET /cities/:id
    # Action method to display detailed information about a specific city.
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

    # GET /cities/:id/edit
    # Action method to edit a specific city.
    # TODO: Manage authorizations to filter who can access this page.
    def edit
    end

    # GET /cities/new
    # Action method to create a new city.
    def new
        @city = City.new
    end

    # POST /cities
    # Action method to send the city creation form.
    def create
        @city = City.new(params[:city])
        if @city.save
            redirect_to @city, :notice => {
                :title => "Success!",
                :message => "City " + @city.name + " was created."
            }
        else 
            render "new"
        end
    end

    # PUT /cities/:id
    # Action method to send the "edit city" form.
    def update
        if @city.update_attributes(params[:city])
            redirect_to @city, :notice => {
                :message => "City " + @city.name + " was updated."
            }
       else
            render "edit"
        end
    end

    # DELETE /cities/:id
    # Action method to delete a specific city.
    def destroy
        @city.destroy
        redirect_to cities_path, :notice => {
            :title => "Success!",
            :message => "City " + @city.name + " was deleted."
        }
    end
end
