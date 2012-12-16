class UsersController < ApplicationController

    # GET /users
    # Action method to display a list of all the users.
    # The presentation of this remains to be decided.
    def index
        @users = User.all
        @user = retrieve_authenticated_user
    end

    # GET /users/:id
    # Action method to display detailed information about a specific user.
    def show
        @user = User.find(params[:id]) 
        @user_me = retrieve_authenticated_user
    end

    # GET /users/:id/edit
    # Action method to edit a specific user.
    # TODO: Manage authorizations to filter who can access this page.
    def edit
        @user = User.find(params[:id])
        @countries = Country.all.map { |country| [country.name, country.id] }        
                
        
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
            redirect_to user_path(@user)
        else 
            render :action => "new"
        end
    end

    # PUT /users/:id
    # Action method to send the "edit user" form.
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
            redirect_to user_path(@user)
        else
            render "edit"
        end
    end

    # DELETE /users/:id
    # Action method to delete a specific user.
    def destroy
        User.find(params[:id]).destroy
        redirect_to users_path
    end
end
