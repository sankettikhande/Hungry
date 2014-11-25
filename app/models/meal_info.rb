class MealInfo < ActiveRecord::Base
  belongs_to :food_item

  attr_accessible :name, :description, :preorder_time, :portion_size, :minimum_order_qty, :short_description,
                  :hola_buy_price, :hola_sell_price, :picture_attributes, :tag_list, :speciality_of_dish

  attr_accessor :is_signature
  has_many :taggings
  has_many :tags, through: :taggings
  acts_as_taggable_on :tags

  has_one :picture, :as => :picturable, :class_name => 'Picture', :dependent => :destroy
  accepts_nested_attributes_for :picture

  validates_presence_of :name, :hola_buy_price, :hola_sell_price, :description, :portion_size, :short_description, :speciality_of_dish
  validates_presence_of :preorder_time, :minimum_order_qty, :if => :signature_dish?
  validates :hola_sell_price, :hola_buy_price, numericality: { only_integer: true }
  # validates_length_of :short_description, :maximum => 100
  validates :preorder_time, :minimum_order_qty, numericality: { only_integer: true}, if: :signature_dish?

  def signature_dish?
		self.is_signature
  end

  def speciality_meal
     return if self.speciality_of_dish.blank?
     # return self.speciality_of_dish.split(",").map {|i| i.downcase}.join(", ")
     return self.speciality_of_dish
  end
end
