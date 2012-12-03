class SessionsController < ApplicationController
	before_filter :layout_setup

	# Filter method to highlight the "Login" tab.
	def layout_setup
		@tab = :login
	end

	# POST /login
	# Action method to validate a user's credentials. And, if successful, set the corresponding session value.
	def create
		# Check the provided credentials against the model authentication method.
		user = User.authenticate(params[:email], params[:password])
		if user
			# If the authentication was successful, set the session value.
			session[:user_id] = user.user_id

			# TODO: Take the "Remember Me" field into account.

			# Redirect to the home page while displaying a success notice.
			redirect_to root_url, :notice => {
				:title => "Logged in!"
			}
		else
			# If the authentication failed, show the login form again.
			render "new"
		end
	end

	# GET /logout
	# Action method to unauthenticate a user.
	def destroy
		# Reset the session authentication value for our user.
		session[:user_id] = nil

		# Redirect to the home page while displaying a success notice.
		redirect_to root_url, :notice => {
			:title => "Logged out!"
		}
	end
end
