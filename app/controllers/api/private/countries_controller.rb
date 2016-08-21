module Api::Private
	class CountriesController < Api::CountriesController

		before_action :authenticate_user!

		def evaluate_target
			if @country
				if required_params
					@data = { price: @country.panel_provider.price }
					@status = 200
				else
					@status = 403
				end
			else
				@status = 404
			end
			render_json_with_status
		end

	end
end
