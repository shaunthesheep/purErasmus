require "rdiscount"

class PagesController < ApplicationController
    before_filter :setup
    before_filter :retrieve_page, :only => [:show, :edit, :update, :destroy]
    layout :page_layout

    # Before filter to detect the City/University, and display the appropriate layout.
    def setup
        city_id = params[:city_id]
        university_id = params[:university_id]

        if (city_id)
            @city = City.find(city_id)
        elsif (university_id)
            @university = University.find(university_id)
        else 
            redirect_to root_url
        end
    end

    # Before filter to retrieve the current page.
    def retrieve_page
        @page = Page.find(params[:id])
    end

    # Method to choose the layout to use.
    def page_layout
        @city ? "layouts/city_detail" : "layouts/university_detail"
    end

    # GET /cities/:city_id/pages/:id
    # GET /universities/:university_id/pages/:id
    # Action method to display a specific page, for a city or a university.
    def show
        @parent_tab = :page
        @md_body = RDiscount.new(@page.body).to_html
    end
    
    # GET /cities/:city_id/pages/:id/edit
    # GET /universities/:university_id/pages/:id/edit
    # Action method to display an "Edit page" form for a specific page.
    def edit
    end

    # GET /cities/:city_id/pages/new
    # GET /universities/:university_id/pages/new
    # Action method to display a form to create a new page.
    def new
        @page = Page.new
    end

    # POST /cities/:city_id/pages
    # POST /universities/:university_id/pages
    # Action method to send the page creation form.
    def create
        @page = Page.new(params[:page])

        if @city
            @page.city = @city
        else
            @page.university = @university
        end

        if @page.save
            redirect_to_page
        else 
            render "new"
        end
    end

    # PUT /cities/:city_id/pages/:id
    # PUT /universities/:university_id/pages/:id
    # Action method to send the "edit page" form.
    def update
        if @page.update_attributes(params[:page])
            redirect_to_page
        else
            render "edit"
        end
    end

    # DELETE /cities/:city_id/pages/:id
    # DELETE /universities/:university_id/pages/:id
    # Action method to delete a specific page.
    def destroy
        @page.destroy
        redirect_to_parent
    end

    # Helper method to redirect to the parent City or University.
    def redirect_to_parent (args = {})
        redirect_to @city ? @city : @university, :notice => args[:notice]
    end

    # Helper method to redirect to the SHOW action of the current page.
    def redirect_to_page (args = {})
        redirect_to @city ? city_page_path(@city, @page) : university_page_path(@university, @page), :notice => args[:notice]
    end

end
