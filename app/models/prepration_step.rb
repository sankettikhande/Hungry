class PreprationStep < ActiveRecord::Base
  belongs_to :sub_menu
  attr_accessible :steps, :sub_heading, :sub_menu_id
end
