class OrderedMenu < ActiveRecord::Base

  belongs_to :order
  belongs_to :dish
  belongs_to :cheff

  validates :order_id, :presence => true
  validates :cheff_id, :presence => true
  validates :dish_id, :presence => true
  validates :quantity, :presence => true

end
