class Dish < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  attr_accessible :dish_image, :ingredients_attributes, :prepration_steps_attributes, :tips_attributes, :tag_list,
                  :pictures_attributes
  has_many :taggings
  has_many :tags, through: :taggings
  acts_as_taggable_on :tags

  belongs_to :cheff, foreign_key: :cheff_id
  has_many :cooking_todays
  has_many :ordered_menus
  has_many :prepration_steps
  has_many :tips
  has_many :ingredients, :dependent => :destroy
  accepts_nested_attributes_for :ingredients
  accepts_nested_attributes_for :prepration_steps
  accepts_nested_attributes_for :tips
  has_attached_file :dish_image

  validates :name, :presence => true
  validates :cheff_id, :presence => true

  has_many :pictures, :as => :picturable, :class_name => 'Picture', :dependent => :destroy
  accepts_nested_attributes_for :pictures
end
