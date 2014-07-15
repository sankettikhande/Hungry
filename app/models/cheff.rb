class Cheff < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  has_many :dishes
  has_many :cooking_todays
  has_many :ordered_menus
  has_many :food_items
  belongs_to :cuisine_geography

  has_many :taggings
  has_many :tags, through: :taggings
  acts_as_taggable_on :tags
  has_one :chef_coordinate,:dependent => :destroy
  accepts_nested_attributes_for :chef_coordinate
  has_one :chef_profile,:dependent => :destroy
  accepts_nested_attributes_for :chef_profile

  attr_accessible :chef_coordinate_attributes, :chef_profile_attributes, :picture_attributes, :tag_list, :cuisine, :cuisine_styles, :cheff_cuisine_geographies, :cuisine_geographies_attributes
  attr_accessor :cuisine

  has_many :cheff_cuisine_styles
  has_many :cuisine_styles, :through => :cheff_cuisine_styles

  has_one :picture, :as => :picturable, :class_name => 'Picture', :dependent => :destroy
  accepts_nested_attributes_for :picture

  has_many :cheff_cuisine_geographies
  has_many :cuisine_geographies, :through => :cheff_cuisine_geographies

  accepts_nested_attributes_for :cuisine_geographies, :allow_destroy => true, :reject_if => :all_blank

  def name
      self.chef_coordinate.name if self.chef_coordinate
  end

  def self.save_cuisine_style(chef, cuisine_style)
     cuisine_style.each do |style|
       CheffCuisineStyle.create(:cheff_id => chef.id, :cuisine_style_id => style.to_i)
     end
  end

  def self.save_cuisine_geographies(chef, cuisine_geographies)
    chef.cuisine_geographies.destroy_all if chef.cuisine_geographies
    cuisine_geographies.each do |cuisine|
      CheffCuisineGeography.create(:cheff_id => chef.id, :cuisine_geography_id => cuisine.to_i )
    end
  end

end
