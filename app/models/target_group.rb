class TargetGroup < ActiveRecord::Base
	belongs_to :panel_provider
	belongs_to :parent, class_name: 'TargetGroup'
	has_many :descendants, class_name: 'TargetGroup', foreign_key: 'parent_id'
	has_and_belongs_to_many :countries

	scope :roots, -> { where parent_id: nil }

	def with_all_descendants
		[self, *nested_descendants(self)]
	end

	private
	def nested_descendants(parent)
		ret = []
		parent.descendants.each do |d|
			ret << d
			ret << nested_descendants(d)
		end
		ret.flatten
	end

end
