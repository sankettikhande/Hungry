class AddSubMenuToContentBlock < ActiveRecord::Migration
  def self.up
    Cms::ContentType.create!(:name => "SubMenu", :group_name => "SubMenu")
  end
end
