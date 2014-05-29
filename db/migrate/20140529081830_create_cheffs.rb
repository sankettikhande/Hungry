class CreateCheffs < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "Cheff", :group_name => "Cheff")
    create_content_table :cheffs, :prefix=>false do |t|
      t.string :name

      t.timestamps
    end
  end
end
