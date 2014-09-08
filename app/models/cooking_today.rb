class CookingToday < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks
  cattr_accessor :meal_types, :meal_type_time_span
  @@meal_types = ["Lunch", "Evening Snacks", "Dinner", "All Time Available"]

  @@meal_type_time_span = {
                           "Lunch" => {from: "11:30 AM", to: "02:00 PM"},
                           "Evening Snacks" => {from: "04:30 PM", to: "08:00 PM"},
                           "Dinner" => {from: "08:00 PM", to: "11:30 PM"},
                           "All Time Available" => {from: "12:00 AM", to: "11:59 PM"}
                          }

  belongs_to :cheff
  belongs_to :food_item

  validates_presence_of :cheff_id, :message => ": Chef's Name and Dish can't be blank"
  validates :date, :presence => true
  validates :meal_type, presence: true
  validates :meal_type, inclusion: {in: @@meal_types}, :unless => Proc.new {|c| c.meal_type.blank?}

  # before_save :set_meal_time
  before_save :set_category

  def name
    "Chef: #{self.cheff.chef_coordinate.name} | Dish: #{self.food_item.meal_info.name} " if self.cheff && self.food_item
  end

  def self.sorted_by_qty_left
    CookingToday.where(:date =>Time.current.to_date).where("meal_from_time > '#{Time.now.to_s(:db)}'").sort_by(&:qty_left).reverse
  end

  def self.grouped_by_category
    sorted_by_qty_left.group_by(&:meal_type)
  end

  def qty_left
    return (self.quantity - self.ordered)
  end

  def set_meal_time
    meal_timing = @@meal_type_time_span[self.meal_type]
    today = DateTime.today
    self.meal_from_time = Time.zone.parse("#{Date.today} #{meal_timing[:from]}")
    self.meal_to_time = Time.zone.parse("#{Date.today} #{meal_timing[:to]}")
  end

  def set_category
    self.category = self.food_item.recipe.category
  end

  def self.todays_menu_by_type meal_type
    where(date: Date.today.to_s, meal_type: meal_type).sort_by(&:qty_left).reverse
  end

  def orderable?
    meal_availability = CookingToday.meal_type_time_span[meal_type]
    meal_availability_from_time = Time.zone.parse("#{Date.today} #{meal_availability[:from]}")
    meal_availability_to_time = Time.zone.parse("#{Date.today} #{meal_availability[:to]}")
    (Time.now > meal_availability_from_time and Time.now < meal_availability_to_time and qty_left > 0)
  end

  def not_orderable?
    meal_availability = CookingToday.meal_type_time_span[meal_type]
    meal_availability_from_time = Time.zone.parse("#{Date.today} #{meal_availability[:from]}")
    meal_availability_to_time = Time.zone.parse("#{Date.today} #{meal_availability[:to]}")
    (Time.now < meal_availability_from_time or Time.now > meal_availability_to_time or qty_left <= 0)
  end
end
