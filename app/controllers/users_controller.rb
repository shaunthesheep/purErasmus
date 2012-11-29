class UsersController < ApplicationController

    # GET /users
    # Action method to display a list of all the users.
    # The presentation of this remains to be decided.
    def index
        @users = User.all
    end

    # GET /users/:id
    # Action method to display detailed information about a specific user.
    def show
        @user = User.find(params[:id]) 
    end

    # GET /users/:id/edit
    # Action method to edit a specific user.
    # TODO: Manage authorizations to filter who can access this page.
    def edit
        @user = User.find(params[:id])
        @universities = University.all.map { |university| [university.name_original, university.id] }
    end

    # GET /users/new
    # Action method to register.
    def new
        @user = User.new
        @countries = Country.all.map { |country| [country.name, country.id] }
    end

    # POST /users
    # Action method to send the registration form.
    def create
        @user = User.new(params[:user])
        if @user.save
            redirect_to root_url
        else 
            render :action => "new"
        end
    end

    # PUT /users/:id
    # Action method to send the "edit user" form.
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
            redirect_to :action => 'show', :id => @user
        else
            render :action => 'edit'
        end
    end

    # DELETE /users/:id
    # Action method to delete a specific user.
    def destroy
        User.find(params[:id]).destroy
        redirect_to :action => 'index'
    end
end
