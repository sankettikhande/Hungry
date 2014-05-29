class AddImageToCheff < ActiveRecord::Migration
  def change
    add_attachment :cheffs, :cheff_image if !column_exists?(:cheffs, :cheff_image)
  end
end
