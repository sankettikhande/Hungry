class CreateCuisineStyles < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "CuisineStyle", :group_name => "CuisineStyle")
    create_table :cuisine_styles do |t|
      t.string :name
      t.timestamps
    end
  end
end
