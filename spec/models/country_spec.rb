require 'rails_helper'

describe Country do

	before(:each) do
		@pp = FactoryGirl.create :panel_provider
		@c = FactoryGirl.create :country, panel_provider_id: @pp.id
	end

	it 'should return locations based on panel provider' do
		lg = FactoryGirl.create :location_group, panel_provider_id: @pp.id, country_id: @c.id
		lgc = FactoryGirl.create :location_group, country_id: @c.id
		lgpp = FactoryGirl.create :location_group, panel_provider_id: @pp.id
		loc = FactoryGirl.create :location
		loc.location_groups = *lg
		locc = FactoryGirl.create :location
		locc.location_groups = *lgc
		locpp = FactoryGirl.create :location
		locpp.location_groups = *lgpp

		expect(@c.locations_based_on_pp.size).to eq 1
		expect(@c.locations_based_on_pp.first).to eq loc
	end

	it 'should return target groups based on panel provider' do
		tg = FactoryGirl.create :target_group, panel_provider_id: @pp.id
		tg.countries = *@c
		tgc = FactoryGirl.create :target_group
		tgc.countries = *@c
		tgpp = FactoryGirl.create :target_group, panel_provider_id: @pp.id

		expect(@c.target_groups_based_on_pp.size).to eq 1
		expect(@c.target_groups_based_on_pp.first).to eq tg
	end

end
