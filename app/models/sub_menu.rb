class SubMenu < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  attr_accessible :title, :picture_attributes, :ingredients_attributes, :prepration_steps_attributes

  belongs_to :recipe
  belongs_to :dish
  has_many :prepration_steps, :dependent => :destroy
  has_many :ingredients, :dependent => :destroy

  accepts_nested_attributes_for :ingredients, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :prepration_steps, :allow_destroy => true, :reject_if => :all_blank

  has_one :picture, :as => :picturable, :class_name => 'Picture', :dependent => :destroy
  accepts_nested_attributes_for :picture

  def name
    "Dish: #{self.dish.name} | SubMenu: #{self.title} " if self.dish && self.title
  end
  def self.display_name
    "Add Ingredient and Steps"
  end
end
