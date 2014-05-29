class Dish < ActiveRecord::Base
  acts_as_content_block

  belongs_to :cheff, foreign_key: :cheff_id

  validate :name, :presence => true
  validate :cheff_id, :presence => true
end
