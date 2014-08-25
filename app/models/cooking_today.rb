class CookingToday < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks
  cattr_accessor :meal_types
  @@meal_types = ["Breakfast", "Brunch", "Lunch", "Evening Snacks", "Dinner"]

  @@meal_type_time_span = {"Breakfast" => {from: "7 AM", to: "11 AM"},
                           "Brunch" => {from: "11 AM", to: "1 PM"},
                           "Lunch" => {from: "1 PM", to: "3 PM"},
                           "Evening Snacks" => {from: "3 PM", to: "7 PM"},
                           "Dinner" => {from: "7 PM", to: "11 PM"}

                          }

  belongs_to :cheff
  belongs_to :food_item

  validates_presence_of :cheff_id, :message => ": Chef's Name and Dish can't be blank"
  validates :date, :presence => true
  validates :meal_type, presence: true
  validates :meal_type, inclusion: {in: @@meal_types}, :unless => Proc.new {|c| c.meal_type.blank?}

  before_save :set_meal_time
  before_save :set_category

  def name
    "Chef: #{self.cheff.chef_coordinate.name} | Dish: #{self.food_item.meal_info.name} " if self.cheff && self.food_item
  end

  def self.sorted_by_qty_left
    CookingToday.where(:date =>Time.current.to_date).where("meal_from_time < '#{Time.now.to_s(:db)}' AND meal_to_time > '#{Time.now.to_s(:db)}'").sort_by(&:qty_left).reverse
  end

  def self.grouped_by_category
    sorted_by_qty_left.group_by(&:category)
  end

  def qty_left
    return (self.quantity - self.ordered)
  end

  def set_meal_time
    meal_timing = @@meal_type_time_span[self.meal_type]
    self.meal_from_time = meal_timing[:from]
    self.meal_to_time = meal_timing[:to]
  end

  def set_category
    self.category = self.food_item.recipe.category
  end
end
