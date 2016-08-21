class User < ActiveRecord::Base
	require 'bcrypt'
	include BCrypt

	attr_accessor :password

	before_create :generate_authentication_token, :hash_password

	def authenticate pwd
		Password.new(self.hashed_password).is_password? pwd
	end

	private
	def generate_authentication_token
		loop do
			self.auth_token = SecureRandom.base64(64)
			break unless User.find_by(auth_token: self.auth_token)
		end
	end

	def hash_password
		self.hashed_password = Password.create(@password)
	end

end
