class Dish < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  attr_accessible :tips_attributes, :tag_list,
                  :picture_attributes, :sub_menus_attributes
  has_many :taggings
  has_many :tags, through: :taggings
  acts_as_taggable_on :tags

  belongs_to :cheff, foreign_key: :cheff_id
  has_many :cooking_todays
  has_many :ordered_menus
  has_many :sub_menus, :dependent => :destroy

  has_many :tips, :dependent => :destroy


  accepts_nested_attributes_for :tips, :reject_if => :all_blank
  accepts_nested_attributes_for :sub_menus, :reject_if => :all_blank

  validates :name, :presence => true
  validates :cheff_id, :presence => true
  validates :price, :presence => true
  validates_presence_of :dish_type

  has_one :picture, :as => :picturable, :class_name => 'Picture', :dependent => :destroy
  accepts_nested_attributes_for :picture
end