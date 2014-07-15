class CreateCuisineContentType < ActiveRecord::Migration
  def up
    Cms::ContentType.create!(:name => "CuisineGeography", :group_name => "CuisineGeography")
  end

  def down
  end
end
