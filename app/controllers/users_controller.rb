class UsersController < ApplicationController
    before_filter :register_layout_setup, :only => [:new, :create]
    before_filter :user_layout_setup, :only => [:edit, :update]

    # This filter is used to set the selected tab for the New and Create actions.
    def register_layout_setup
        @tab = :register
    end

    # This filter is used to set the selected tab for the Edit and Update actions.
    def user_layout_setup
        @tab = :user
    end

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
<<<<<<< HEAD
        @user = User.find(params[:id])
        @countries = Country.all.map { |country| [country.name, country.id] }        
                
        
=======
        @user = User.find(params[:id])        
        @countries = Country.all.map { |country| [country.name, country.id] }
>>>>>>> 94a21600b3649cc3fa6da8665f780a7b400c2687
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
<<<<<<< HEAD
            redirect_to user_path(@user)
=======
            redirect_to root_url, :notice => {
                :title => "Success!",
                :message => "Your are now a Purerasmus member."
            }
>>>>>>> 94a21600b3649cc3fa6da8665f780a7b400c2687
        else 
            render :action => "new"
        end
    end

    # PUT /users/:id
    # Action method to send the "edit user" form.
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
<<<<<<< HEAD
            redirect_to user_path(@user)
=======
            redirect_to @user, :notice => {
                :message => "Your profile was updated."
            }
>>>>>>> 94a21600b3649cc3fa6da8665f780a7b400c2687
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
