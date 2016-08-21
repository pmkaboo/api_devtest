require 'rails_helper'

module Api::V1::Private
	describe CountriesController do
		before(:each) do
			@user = FactoryGirl.create :user
		end
		context 'access' do
			context 'with credentials' do
				it 'should allow with token' do
					request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token, name: @user.name)

					get :locations, country_code: 'cc'
					expect(response.status).to eq 404

					get :target_groups, country_code: 'cc'
					expect(response.status).to eq 404

					get :evaluate_target
					expect(response.status).to eq 404
				end

				it 'should allow with basic auth' do
					request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(@user.name, 'pass')

					get :locations, country_code: 'cc'
					expect(response.status).to eq 404

					get :target_groups, country_code: 'cc'
					expect(response.status).to eq 404

					post :evaluate_target
					expect(response.status).to eq 404
				end
			end

			context 'without credential' do
				it 'should deny' do
					get :locations, country_code: 'cc'
					expect(response.status).to eq 401

					get :target_groups, country_code: 'cc'
					expect(response.status).to eq 401

					post :evaluate_target
					expect(response.status).to eq 401
				end
			end
		end

		context 'POST evaluate target' do
			before(:each) do
				@pp = FactoryGirl.create :panel_provider
				@c = FactoryGirl.create :country, panel_provider_id: @pp.id
				@loc = FactoryGirl.create :location
				@tg = FactoryGirl.create :target_group
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token, name: @user.name)
				allow(ProviderPriceCalcs).to receive(:type_a).and_return(10)
			end

			it 'should return price with valid params' do
				post :evaluate_target, country_code: @c.country_code, target_group_id: @tg.id, locations: [{ id: @loc.id, panel_size: 200 }]
				expect(json['price'].to_i).to eq 10
				expect(response.status).to eq 200
			end

			it 'should return 404 without valid params' do
				post :evaluate_target, country_code: @c.country_code, target_group_id: @tg.id
				expect(response.status).to eq 404

				post :evaluate_target, country_code: @c.country_code, locations: [{ id: @loc.id, panel_size: 200 }]
				expect(response.status).to eq 404

				post :evaluate_target, target_group_id: @tg.id, locations: [{ id: @loc.id, panel_size: 200 }]
				expect(response.status).to eq 404

				post :evaluate_target, country_code: 'cc', target_group_id: @tg.id, locations: [{ id: @loc.id, panel_size: 200 }]
				expect(response.status).to eq 404

				post :evaluate_target, country_code: @c.country_code, target_group_id: '123', locations: [{ id: @loc.id, panel_size: 200 }]
				expect(response.status).to eq 404

				post :evaluate_target, country_code: @c.country_code, target_group_id: @tg.id, locations: [{ id: '456', panel_size: 200 }]
				expect(response.status).to eq 404
			end
		end
	end
end
