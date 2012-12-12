class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :retrieve_authenticated_user

    def retrieve_authenticated_user
        user_id = session[:user_id]

        # If we have a logged-in user, retrieve it.
        if user_id
            @site_user = User.find(user_id)
        end
    end

end
