class CreateBanners < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "Banner", :group_name => "Banner")
    create_content_table :banners, :prefix=>false do |t|
      t.string :name
      t.string :banner_type
      t.date :start_date
      t.date :end_date
      t.text :description, :size => (64.kilobytes + 1)
      t.string :target_url
      t.text :pages_to_display
      t.integer :height
      t.integer :width

      t.timestamps
    end
  end
end
