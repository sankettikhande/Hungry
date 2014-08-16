class Order < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  @@order_statuses = ["Created", "Confirmed", "Dispatched", "Damaged", "Delivered", "Canceled", "Returned", "Waiting for Payment"]
  attr_accessor :skip_callbacks
  cattr_accessor :order_statuses

  serialize :payment_gateway_response, Hash

  has_many :ordered_menus
  belongs_to :hola_user

  validates :date, :order_status, :presence => true
  validates :order_status, inclusion: {in: @@order_statuses}



  def self.create_signature_menus(order, signature_dish, menus)
    ordered_menu = OrderedMenu.create(:order_id => order.id, :quantity => menus[:quantity],
                                    :rate => signature_dish.meal_info.hola_sell_price, :dish_id => signature_dish.id,
                                    :cheff_id => signature_dish.cheff_id)
    order.update_attributes(:total => ordered_menu.rate * ordered_menu.quantity)
  end

  def self.save_user(params)
    hola_user = HolaUser.find_by_phoneNumber(params[:orders][:mobile_no])
    if params[:save_user_details]
      if hola_user
        existing_adds = hola_user.hola_user_addresses.where(mobile_no: params[:orders][:mobile_no]).first
        if existing_adds
          existing_adds.update_attributes(params[:orders])
        else
          default = hola_user.hola_user_addresses.count == 0 ? true : false
          adds = hola_user.hola_user_addresses.new(params[:orders])
          adds.default = default
          adds.address_type = 'Home'
          adds.save
        end
      else
        hola_user = HolaUser.create(:name => params[:orders][:name], :phoneNumber => params[:orders][:mobile_no])
        adds = hola_user.hola_user_addresses.new(params[:orders])
        adds.default = true
        adds.address_type = 'Home'
        adds.save
      end
    end
    return hola_user
  end

  def self.check_signature_order_delivery_date(order_date)
    date_now = Date.today
    date_delivery = Date.parse(order_date)
    date_diff = (date_delivery - date_now).to_i
    return date_diff
  end

  def bill_amount
    ordered_menus.map(&:ordered_menu_bill).sum
  end

end
