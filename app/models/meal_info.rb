class MealInfo < ActiveRecord::Base
  belongs_to :food_item

  attr_accessible :name, :description, :preorder_time, :portion_size, :minimum_order_qty,
                  :hola_buy_price, :hola_sell_price, :picture_attributes, :tag_list

  has_many :taggings
  has_many :tags, through: :taggings
  acts_as_taggable_on :tags

  has_one :picture, :as => :picturable, :class_name => 'Picture', :dependent => :destroy
  accepts_nested_attributes_for :picture

  validates_presence_of :name, :hola_buy_price, :hola_sell_price, :preorder_time, :portion_size, :minimum_order_qty
end
