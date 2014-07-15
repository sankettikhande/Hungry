class CreateChefProfiles < ActiveRecord::Migration
  def change
    create_table :chef_profiles do |t|
      t.integer :cheff_id
      t.text :about_me
      # Typical Day
      t.text :why_i_love_cooking
      t.text :people_places_that_inspire_my_food
      t.text :best_compliment
      t.text :why_do_i_want_to_join_hola
      t.string :facebook_handle
      t.string :twitter_handle
      t.text :banners
      t.text :brand_represented
      t.text :brand_info
      t.text :brand_banner
      t.timestamps
    end
    add_column :chef_profiles, :brand_logo_file_name, :string
    add_column :chef_profiles, :brand_logo_content_type, :string
    add_column :chef_profiles, :brand_logo_file_size, :integer
    add_column :chef_profiles, :brand_logo_updated_at, :datetime
  end
end
