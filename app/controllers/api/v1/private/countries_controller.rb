module Api::V1::Private
	class CountriesController < Api::V1::CountriesController

		before_action :authenticate_user!

		def evaluate_target
			if params_valid?
				@data = { price: @country.panel_provider.price }
				@status = 200
			else
				@status = 404
			end
			render_json_with_status
		end

		private
		def eval_params
			params.permit(:country_code, :target_group_id, locations: [:id, :panel_size])
		end

		def params_valid?
			@country.present? &&
				eval_params.size == 3 &&
				TargetGroup.find_by_id(eval_params[:target_group_id]).present? &&
				locations_valid?
		end

		def locations_valid?
			eval_params[:locations].all? do |location|
				Location.find_by_id(location[:id]).present?
			end
		end

	end
end
