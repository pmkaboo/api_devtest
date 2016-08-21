# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do |x|
	Location.create name: "location_#{x}"
end

pricings = %w[node type_b type_a]
3.times do |x|
	p = PanelProvider.create code: "provider_#{x}", pricing: pricings.pop
	c = Country.create panel_provider_id: p.id, country_code: "country_#{x}"
	LocationGroup.create panel_provider_id: p.id, country_id: c.id, name: "location_group_#{x}"
	TargetGroup.create panel_provider_id: p.id, name: "target_group_#{x}"
end
c = Country.all.sample
LocationGroup.create panel_provider_id: c.panel_provider_id, country_id: c.id, name: "location_group_special"
TargetGroup.create panel_provider_id: c.panel_provider_id, name: "target_group_special"

TargetGroup.all.each do |tg|
	x = 0
	parent = tg
	until x == 3
		parent = TargetGroup.create name: "target_group_nested_#{TargetGroup.count+10}", parent_id: parent.id
		x += 1
	end
end

Location.all.each do |l|
	l.location_groups = LocationGroup.all.sample(rand(4)+1)
end

TargetGroup.roots.each do |tg|
	tg.countries = Country.all.sample(rand(3)+1)
end

User.create name: 'test', password: 'pass'
