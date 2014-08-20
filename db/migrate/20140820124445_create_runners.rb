class CreateRunners < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "Runner", :group_name => "Runner")
    create_content_table :runners, :prefix=>false do |t|
      t.string :name
      t.string :phone
      t.text :address

      t.timestamps
    end
  end
end
