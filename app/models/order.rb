class Order < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  has_many :ordered_menus

  #validates :name, :presence => true
  #validates :address, :presence => true
  validates :date, :presence => true
  #validates :phone_no, :presence => true

  def self.create_signature_menus(order, signature_dish, menus)
    ordered_menu = OrderedMenu.create(:order_id => order.id, :quantity => menus[:quantity],
                                    :rate => signature_dish.price, :dish_id => signature_dish.id,
                                    :cheff_id => signature_dish.cheff_id)
    order.update_attributes(:total => ordered_menu.rate * ordered_menu.quantity)
  end
end
