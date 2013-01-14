require "net/http"
require "uri"

class UniversitiesController < ApplicationController
    before_filter :city_layout_setup

    layout "university_detail", :only => [:show]

    # This filter is used to set the selected tab.
    def city_layout_setup
        @tab = :university
    end

    # GET /universities
    # GET /countries/:country_id/universities
    # GET /cities/:city_id/universities
    # Action method to retrieve a list of universities. Can be returned in multiple formats.
    def index
        country_id = params[:country_id]
        city_id = params[:city_id]
        @user = retrieve_authenticated_user

        # If we have a countryId, return only the universities for the specified country.
        if (country_id)
            @universities = Country.find(country_id).cities.map { |city| city.universities }.flatten
        # If we have a cityId, return only the universities for the specified city.
        elsif (city_id)
            @universities = City.find(city_id).universities
        # Otherwise, return all the universities.
        else
            @universities = University.all
        end

        # Decide on the return format.
        respond_to do |format|
            format.json { render :json => @universities }
            format.html { render }
        end
    end

    # GET /universities/:id
    # Action method to display a specific university.
    def show
        page_id = params[:page_id]
        @user = retrieve_authenticated_user
        @university = University.find(params[:id])
        if (page_id)
            @page = Page.find(page_id)
        else
            @page = @university.pages.first
        end
    end

    # GET /universities/new
    # Action method to display a "new university" form.
    def new
        @university = University.new
        @cities = City.all.map { |city| [city.name, city.id] }

        # Select a city if needed.
        @university.city = City.find(params[:city]) if params[:city]
    end

    # GET /universities/:id/edit
    # Action method to display an "edit university" form for a specific university.
    def edit
        @university = University.find(params[:id])
        @cities = City.all.map { |city| [city.name, city.id] }
    end

    # POST /universities
    # Action method to post a "new university" form and create the corresponding university.
    def create
        @university = University.new(params[:university])
        if @university.save
            redirect_to university_path(@university)
        else 
            render :new
        end
    end

    # PUT /universities/:id
    # Action method to post an "edit university" form and update the corresponding university.
    def update
        @university = University.find(params[:id])
        if @university.update_attributes(params[:university])
            redirect_to university_path(@university)
        else
            render :edit
        end
    end

    # DELETE /universities/:id
    # Action method to delete a specific university.
    def destroy
        @university = University.find(params[:id])
        @university.destroy
        redirect_to universities_path
    end

    # GET /universities/:id/photo
    def photo
        @university = University.find(params[:id])
        api_key = "AIzaSyAWyCseSbFQ2MckF9Dj0M0FyJlydtcTYIM"
        default_image = "/assets/university_default.png"

        # Do a first request for the place.
        query = URI.encode("#{@university.name_original} #{@university.city.name} #{@university.city.country.name}")
        uri = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{query}&key=#{api_key}&sensor=false"

        res = dorequest(uri)

        # Parse the response.
        place_res = ActiveSupport::JSON.decode(res.body)

        # First, redirect to the default photo if we didn't find any.
        return redirect_to(default_image) if place_res["results"].size == 0 || !place_res["results"][0]["photos"]

        # Then extract the reference to the photo.
        photo_ref = place_res["results"][0]["photos"][0]["photo_reference"]

        # Now redirect to the actual photo.
        redirect_to "https://maps.googleapis.com/maps/api/place/photo?photoreference=#{photo_ref}&key=#{api_key}&sensor=false&maxwidth=470"
    end

    def dorequest (url)
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(uri.request_uri)

        http.request(request)
    end

end
