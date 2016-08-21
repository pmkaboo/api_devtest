class Api::ApiController < ApplicationController

	before_action :destroy_session

	attr_accessor :current_user

	def destroy_session
		request.session_options[:skip] = true
	end

	def authenticate_user!
		unless authenticate_from_token || authenticate_by_password
			@status = 401
			render_json_with_status
			return
		end
	end

	def render_json_with_status
		if @data
			@data[:credentials] = {token: @current_user.auth_token, name: @current_user.name} if @current_user
			render json: @data, status: @status
		else
			render nothing: true, status: @status
		end
	end

	private
	def authenticate_from_token
		token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

		user_name = options.blank?? nil : options[:name]
		user = user_name && User.find_by(name: user_name)

		user && ActiveSupport::SecurityUtils.secure_compare(user.auth_token, token)
	end

	def authenticate_by_password
		if user_params
			user = User.find_by(name: user_params[:name])

			@current_user = user

			user && user.authenticate(user_params[:password])
		else
			false
		end
	end

	def user_params
		params.permit(user: [:name, :password])[:user]
	end

end
