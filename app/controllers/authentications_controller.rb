class AuthenticationsController < ApplicationController
	def create
		auth = env['omniauth.auth']
		access_token = auth.credentials.token if auth.credentials.present?

		if access_token.present?
			authentication = Authentication.find_or_create_by(provider: auth.provider)
			authentication.access_token = access_token
			authentication.save
		end

		redirect_to :root
	end
end
