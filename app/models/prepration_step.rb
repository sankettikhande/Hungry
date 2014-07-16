class PreprationStep < ActiveRecord::Base
  belongs_to :sub_menu

  attr_accessible :steps, :sub_heading, :sub_menu_id, :picture_attributes

  has_one :picture, :as => :picturable, :class_name => 'Picture', :dependent => :destroy
  accepts_nested_attributes_for :picture
end
