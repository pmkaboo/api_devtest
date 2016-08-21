module Api
	class CountriesController < ApiController

		before_filter :get_country

		def locations
			if @country
				@data = { locations: @country.locations_based_on_pp }
				@status = 200
			else
				@status = 404
			end
			render_json_with_status
		end

		def target_groups
			if @country
				@data = { groups: @country.target_groups_based_on_pp }
				@status = 200
			else
				@status  = 404
			end
			render_json_with_status
		end

		private
		def get_country
			@country = Country.find_by_country_code(params[:country_code])
		end

		def required_params
			params.permit(:country_code, :target_group_id, locations: [:id, :panel_size]).count == 3
		end
	end
end
