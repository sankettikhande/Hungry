class MealInfo < ActiveRecord::Base
  belongs_to :food_item

  attr_accessible :name, :description, :preorder_time, :portion_size, :minimum_order_qty, :short_description,
                  :hola_buy_price, :hola_sell_price, :picture_attributes, :tag_list

  attr_accessor :is_signature
  has_many :taggings
  has_many :tags, through: :taggings
  acts_as_taggable_on :tags

  has_one :picture, :as => :picturable, :class_name => 'Picture', :dependent => :destroy
  accepts_nested_attributes_for :picture

  validates_presence_of :name, :hola_buy_price, :hola_sell_price, :description, :portion_size, :short_description
  validates_presence_of :preorder_time, :minimum_order_qty, :if => :signature_dish?
  validates :hola_sell_price, :hola_buy_price, numericality: { only_integer: true }
  # validates_length_of :short_description, :maximum => 100
  validates :preorder_time, :minimum_order_qty, numericality: { only_integer: true}, if: :signature_dish?

  def signature_dish?
		self.is_signature
  end
end
