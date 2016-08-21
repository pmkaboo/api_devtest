class CreateTables < ActiveRecord::Migration
	def change
		create_table :countries do |t|
			t.string :country_code
			t.integer :panel_provider_id
		end

		create_table :panel_providers do |t|
			t.string :code
		end

		create_table :locations do |t|
			t.string :name
			t.integer :external_id
			t.string :secret_code
		end

		create_table :location_groups do |t|
			t.string :name
			t.integer :country_id
			t.integer :panel_provider_id
		end

		create_table :location_groups_locations do |t|
			t.integer :location_id
			t.integer :location_group_id
		end

		create_table :target_groups do |t|
			t.string :name
			t.integer :external_id
			t.integer :parent_id
			t.string :secret_code
			t.integer :panel_provider_id
		end

		create_table :countries_target_groups do |t|
			t.integer :country_id
			t.integer :target_group_id
		end
	end
end
