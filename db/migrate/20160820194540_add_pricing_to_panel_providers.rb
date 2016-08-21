class AddPricingToPanelProviders < ActiveRecord::Migration
  def change
    add_column :panel_providers, :pricing, :string
  end
end
