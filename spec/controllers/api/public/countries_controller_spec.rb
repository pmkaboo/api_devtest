require 'rails_helper'

module Api::Public
	describe CountriesController do
		context 'access without credential' do
			it 'should allow' do
				get :locations, country_code: 'cc'
				expect(response.status).to eq 404

				get :target_groups, country_code: 'cc'
				expect(response.status).to eq 404
			end
		end

		context 'actions' do
			before(:each) do
				@pp = FactoryGirl.create :panel_provider
				@c = FactoryGirl.create :country, panel_provider_id: @pp.id
			end

			context 'GET locations' do
				before(:each) do
					@lg = FactoryGirl.create :location_group, panel_provider_id: @pp.id, country_id: @c.id
					@lgc = FactoryGirl.create :location_group, country_id: @c.id
					@lgpp = FactoryGirl.create :location_group, panel_provider_id: @pp.id
					@loc = FactoryGirl.create :location
					@loc.location_groups = *@lg
					@locc = FactoryGirl.create :location
					@locc.location_groups = *@lgc
					@locpp = FactoryGirl.create :location
					@locpp.location_groups = *@lgpp
				end

				it 'should return locations based on panel provider' do
					get :locations, country_code: @c.country_code
					expect(json['locations'].size).to eq 1
					expect(json['locations']).to include @loc.attributes
					expect(response.status).to eq 200
				end

				it 'should return 404 for incorrect country code' do
					get :locations, country_code: 'random'
					expect(response.status).to eq 404
				end
			end

			context 'GET target groups' do
				before(:each) do
					@tg = FactoryGirl.create :target_group, panel_provider_id: @pp.id
					@tg.countries = *@c
					@tgc = FactoryGirl.create :target_group
					@tgc.countries = *@c
					@tgpp = FactoryGirl.create :target_group, panel_provider_id: @pp.id
				end

				it 'should return target groups based on panel provider' do
					get :target_groups, country_code: @c.country_code
					expect(json['groups'].size).to eq 1
					expect(json['groups']).to include @tg.attributes
					expect(response.status).to eq 200
				end

				it 'should return 404 for incorrect country code' do
					get :target_groups, country_code: 'random'
					expect(response.status).to eq 404
				end
			end
		end
	end
end
