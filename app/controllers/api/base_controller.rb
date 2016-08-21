class Api::BaseController < ApplicationController
	protect_from_forgery with: :null_session

	before_action :destroy_session

	attr_accessor :current_user

	def destroy_session
		request.session_options[:skip] = true
	end

	def authenticate_user!
		authenticate_from_token || authenticate_by_password
	end

	def render_json_with_status
		if @data.present?
			@data[:credentials] = {token: @current_user.auth_token, name: @current_user.name} if @current_user
			render json: @data, status: @status
		else
			render nothing: true, status: @status
		end
	end

	private
	def authenticate_from_token
		token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

		name = options.blank?? nil : options[:name]
		user = name && User.find_by_name(name)

		user && ActiveSupport::SecurityUtils.secure_compare(user.auth_token, token)
	end

	def authenticate_by_password
		authenticate_or_request_with_http_basic do |username, password|
			if user = User.find_by_name(username)
				@current_user = user
				user.authenticate password
			else
				false
			end
		end
	end

end
