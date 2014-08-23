class CreateChefRequests < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "ChefRequest", :group_name => "ChefRequest")
    create_content_table :chef_requests, :prefix=>false do |t|
      t.string :name
      t.integer :mobile_number
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
