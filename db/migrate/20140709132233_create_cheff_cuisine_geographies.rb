class CreateCheffCuisineGeographies < ActiveRecord::Migration
  def change
    create_table :cheff_cuisine_geographies do |t|
      t.integer :cuisine_geography_id
      t.integer :cheff_id
      t.timestamps
    end
  end
end
