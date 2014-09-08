class Order < ActiveRecord::Base
  acts_as_content_block({:versioned => false})

  @@order_statuses = ["Created", "Confirmed", "Dispatched", "Damaged", "Delivered", "Canceled", "Returned", "Reordered"]
  @@payment_status = ["Waiting for Payment", "Payment Gateway Failed", "Paid", "On Delivery", "User Canceled"]
  attr_accessor :skip_callbacks
  cattr_accessor :order_statuses



  serialize :payment_gateway_response, Hash
  serialize :order_status_history, Array

  has_many :ordered_menus
  belongs_to :hola_user
  belongs_to :runner

  validates :date, :order_status, presence: true
  validates :order_status, inclusion: {in: @@order_statuses}
  validates :return_reason, presence: true, :if => Proc.new {|o| o.order_status == "Returned"}

  after_save :mark_paid, :send_delivery_message, :if => :delivered?
  after_save :mark_menu_items, :if => Proc.new { |o| ["Damaged", "Delivered", "Canceled", "Returned"].include? o.order_status }
  after_save :send_order_confirm_message, :if => :confirmed?
  after_save :send_order_dispatched_message, :if => :dispatched?
  before_save :build_order_status_history
  before_save :ensure_hola_user_id
  before_save :update_timestamps

  @@order_statuses.each do |s|
    define_method "#{s.downcase}?" do
      order_status == s
    end
  end

  def mark_paid
    if payment_status != "Paid"
      update_column(:payment_status, "Paid")
    end
  end

  def send_order_confirm_message
    invoice_url = Settings.iframe_domain_url + "/show_invoice/#{self.id}"
    message = "Hola! Our chef has received your order and is on it already. Your order number is #{self.id} for Rs. #{self.total}."
    MessagingLib.send_messages(message, self.phone_no, "Transaction")
  end

  def send_order_dispatched_message
    message = "Hola! Your HolaChef order has been dispatched. Our delivery service ELVIS is on its way. For Order feedback
              message Delighted or Disappointed on 808080HOLA."
    MessagingLib.send_messages(message, self.phone_no, "Transaction")
  end

  def send_delivery_message
    message = "Hola! Hope you had an awesome experience with HolaChef, the only multi cuisine restaurant delivering food
          from chefs to right at your doorsteps."
    MessagingLib.delay(:run_at => 2.hours.from_now).send_messages(message, self.phone_no, "Transaction")
  end

  def mark_menu_items
    ordered_menus.where(order_status: "Ordered").map {|om| om.update_attribute(:order_status, order_status)}
  end

  def build_order_status_history
    self.order_status_history << order_status if order_status_changed? and self.order_status_history.last != order_status
  end

  def order_status_history_string
    order_status_history.join(", ")
  end

  def update_timestamps
    self.dispatched_at = Time.now if self.dispatched?
    self.delivered_at = Time.now if self.delivered?
  end

  def delivery_time
    return nil if delivered_at.blank? or dispatched_at.blank?
    (delivered_at - dispatched_at).to_i
  end

  def ensure_hola_user_id
    if hola_user_id.blank?
      hola_user = HolaUser.find_by_phoneNumber self.phone_no
      self.hola_user_id = hola_user.id unless hola_user.blank?
    end
  end

  def self.create_signature_menus(order, signature_dish, menus)
    ordered_menu = OrderedMenu.create(:order_id => order.id, :quantity => menus[:quantity],
                                    :rate => signature_dish.meal_info.hola_sell_price, :dish_id => signature_dish.id,
                                    :cheff_id => signature_dish.cheff_id)
    order.update_attributes(:total => ordered_menu.rate * ordered_menu.quantity)
  end

  def self.save_user(params)
    hola_user = HolaUser.find_by_id(params[:hola_user_id]) unless params[:hola_user_id].blank?
    hola_user = HolaUser.find_by_phoneNumber params[:orders][:mobile_no] if hola_user.blank?
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
    ordered_menus.where(order_status: ["Ordered", "Delivered"]).map(&:ordered_menu_bill).sum
  end

  def build_session
    session_cart_items = []
    ordered_menus.each do |menu|
      session_cart_items << {"#{menu.dish_id}" =>{'quantity'=> menu.quantity, 'price' => menu.rate, 'date' => date, 'dish_name' => menu.food_item.name }}
    end
    session_cart_items
  end

end
