class Order < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  serialize :payment_gateway_response, Hash

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

  def self.save_user(params)
    hola_user = HolaUser.find_by_phoneNumber(params[:orders][:phone_no])
    if params[:save_user_details]
      if hola_user
        hola_user.update_attributes(:name => params[:orders][:name], :phoneNumber => params[:orders][:phone_no])
        HolaUserAddress.create(:address => params[:orders][:address],
                               :hola_user_id => hola_user.id) if !hola_user.hola_user_addresses.map(&:address).include?(params[:orders][:address].strip)
      else
        hola_user = HolaUser.create(:name => params[:orders][:name], :phoneNumber => params[:orders][:phone_no])
        HolaUserAddress.create(:address => params[:orders][:address].strip, :hola_user_id => hola_user.id)  if hola_user
      end
    else
      HolaUserAddress.create(:address => params[:orders][:address],
                             :hola_user_id => hola_user.id) if hola_user && !hola_user.hola_user_addresses.map(&:address).include?(params[:orders][:address].strip)
    end
    return hola_user
  end


end
