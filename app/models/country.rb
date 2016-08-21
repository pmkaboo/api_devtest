class Country < ActiveRecord::Base
	belongs_to :panel_provider
	has_many :location_groups
	has_and_belongs_to_many :target_groups, -> { where parent_id: nil }

	def locations_based_on_pp
		groups = location_groups.where(panel_provider_id: self.panel_provider_id)
		groups.map { |g| g.locations }.flatten
	end

	def target_groups_based_on_pp
		groups = target_groups.where(panel_provider_id: self.panel_provider_id)
		groups.map { |g| g.with_all_descendants }.flatten
	end
end
