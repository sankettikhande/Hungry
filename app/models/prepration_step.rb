class PreprationStep < ActiveRecord::Base
  belongs_to :dish
  attr_accessible :steps, :sub_heading
end
