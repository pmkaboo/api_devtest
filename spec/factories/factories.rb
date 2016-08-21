FactoryGirl.define do
	factory :user do
		name 'test'
		password 'pass'
	end

	factory :panel_provider do
		sequence(:code) { |n| "provider_#{n}" }
		pricing :type_a
	end

	factory :country do
		sequence(:country_code) { |n| "country_#{n}" }
	end
	factory :location do
		sequence(:name) { |n| "location_#{n}" }
	end

	factory :location_group do
		sequence(:name) { |n| "lgroup_#{n}" }
	end

	factory :target_group do
		sequence(:name) { |n| "tgroup_#{n}" }
	end
end
