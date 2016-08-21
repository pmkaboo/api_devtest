module Api::V1
	class CountriesController < BaseController

		before_filter :get_country

		def locations
			if @country.present?
				@data = { locations: @country.locations_based_on_pp }
				@status = 200
			else
				@status = 404
			end
			render_json_with_status
		end

		def target_groups
			if @country.present?
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
	end
end
