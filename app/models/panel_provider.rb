class PanelProvider < ActiveRecord::Base
	has_many :countries
	has_many :location_groups
	has_many :target_groups

	# price should be recalculated on each request?
	def price
		ProviderPriceCalcs.send(pricing)
	end
end
