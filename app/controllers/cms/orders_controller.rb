require "#{Rails.root}/lib/citrus_lib.rb"
include ApplicationHelper
class Cms::OrdersController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:email_invoice, :set_cart, :payment_gateway,:order_confirm,
                                                                     :remove_from_cart, :create_signature_order, :callback,
                                                                     :submit_payment_form, :add_address]
  def set_cart
    session[:cart] = [] if session[:cart].nil?
    cart_ids = []
    cart_ids = session[:cart].collect{|item| item.keys}.flatten
    if cart_ids.include?(params[:item_id])
       session[:cart].each do |item|
         session[:cart].delete(item) if item.keys.flatten.include?(params[:item_id])
       end
       session[:cart] << ({params[:item_id]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date], 'dish_name' => params[:dish_name],'category' => params[:category], 'meal_type' => params[:meal_type] }})
    else
      session[:cart] << ({params[:item_id]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date], 'dish_name' => params[:dish_name],'category' => params[:category], 'meal_type' => params[:meal_type] }})
    end
    @total = 0
    if !session[:cart].nil?
      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          @total = @total + (item_attr['quantity'].to_i * item_attr['price'].to_i)
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def remove_from_cart
    session[:cart].each do |item|
      key = item.keys.collect{|c| c.to_i}.join('').to_i
      if key == params[:item_id].to_i
        session[:cart].delete(item)
      end
    end
    @total = 0
    if !session[:cart].nil?
      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          @total = @total + (item_attr['quantity'].to_i * item_attr['price'].to_i)
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def add_address
    session[:lt] = params[:lt] == 'undefined' ? nil : params[:lt]
    session[:dt] = params[:dt] == 'undefined' ? nil : params[:dt]
    session[:et] = params[:et] == 'undefined' ? nil : params[:et]
    if hola_current_user
      @adds = hola_current_user.hola_user_addresses.default_address.first
      @adds = hola_current_user.hola_user_addresses.build(name: hola_current_user.name, mobile_no: hola_current_user.phoneNumber) unless @adds
      @adds_types = hola_current_user.hola_user_addresses.collect{|ads| ads.address_type}.compact
    else
      @adds = HolaUserAddress.new
    end
    render layout: 'application'
  end

  def create_multi_meal_order cart_meal_types, hola_user, hola_user_address
    meal_type_length = cart_meal_types.length

    @order = Order.create(:date => Time.now, :order_status => "Created", :order_type => 'MultiMeal',
                            :hola_user_id => hola_user.id, :addressStreet1 => hola_user_address.building_name, :addressStreet2 => hola_user_address.street,
                            :landmark => hola_user_address.landmark, :addressZip => hola_user_address.pin, :phone_no => hola_user_address.mobile_no, :name => hola_user.name)
    @orders_by_meal_type = {}
    cart_meal_types.each do |meal_type|

      time_slot = get_time_slot(meal_type)

      order = Order.create(:date => Time.now, :order_status => "Created", :order_type => 'Regular',
                        :hola_user_id => hola_user.id, :addressStreet1 => hola_user_address.building_name, :addressStreet2 => hola_user_address.street,
                        :landmark => hola_user_address.landmark, :addressZip => hola_user_address.pin, :phone_no => hola_user_address.mobile_no,
                        :name => hola_user.name, parent_order_id: @order.id, delivery_slot: time_slot)


      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          next if item_attr['meal_type'] != meal_type
          cooking_today  = CookingToday.find(item_id)
          if cooking_today.not_orderable?
            return "NotOrderableItem" #clean_up_orders(orders_by_meal_type)
          end
          food_item = cooking_today.food_item
          if !order.blank?
            menu = OrderedMenu.create(:order_id => order.id,:dish_id => food_item.id, :cooking_today_id => cooking_today.id,
                                      :cheff_id => food_item.cheff.id, :quantity => item_attr['quantity'],
                                      :rate => item_attr['price'])

            @coupon = Coupon.find_by_id(item_attr["coupon_id"])
            if !@coupon.blank?
              @coupon_id = item_attr["coupon_id"]
              used_count = @coupon.no_of_used_coupons.to_i + 1
              Coupon.where(:id => item_attr["coupon_id"]).update_all(:no_of_used_coupons => used_count)
              @coupon.hola_users << hola_user
            else
              @discount_amount = 0
              @coupon_id = 0
            end
          end
        end
      end
      mrp = OrderedMenu.calculate_mrp(order)
      if !@coupon.blank?
        discount = @coupon.flat.blank? ? @coupon.percentage : @coupon.flat
        discount_type = @coupon.flat.blank? ? "percentage" : "flat"
        discount_amount = (@discount_type=='flat') ? discount : Coupon.calculate_percentage(mrp, discount)
      else
        discount_amount = 0
      end
      order.update_attributes(:total => (OrderedMenu.calculate_total(order, discount_amount, meal_type_length)), :coupon_id => @coupon_id, :mrp=> mrp )
      @orders_by_meal_type.merge!(meal_type => order)

    end
    "OK"
  end

  def payment_gateway
    hola_user = hola_current_user#Order.save_user(params)
    hola_user_address = hola_user.hola_user_addresses.find_by_id(params[:address_id])
    if hola_user_address.blank?
      redirect_to "/add-address" and return
    else
      cart_meal_types = session[:cart].collect{|i| i.values.collect{|v| v['meal_type']}}.flatten.uniq
      meal_type_length = cart_meal_types.length

      if cart_meal_types.length > 1
        response = create_multi_meal_order(cart_meal_types, hola_user, hola_user_address)
        if response != "OK"
          @orders_by_meal_type.each do |meal_type, order|
            order.destroy
          end
          @order.destroy
          session[:cart] = []
          redirect_to("/mobile", alert: "Sorry! There were some menus in your cart that we can't serve right now.") and return
        end
      else
        @order = Order.create(:date => Time.now, :order_status => "Created", :order_type => 'Regular',
                            :hola_user_id => hola_user.id, :addressStreet1 => hola_user_address.building_name, :addressStreet2 => hola_user_address.street,
                            :landmark => hola_user_address.landmark, :addressZip => hola_user_address.pin, :phone_no => hola_user_address.mobile_no, :name => hola_user.name, delivery_slot:  get_time_slot(cart_meal_types) )

        session[:cart].each do |item|
          item.each do |item_id, item_attr|

            @order.delivery_slot = get_time_slot(item_attr["meal_type"])
            @order.save

            cooking_today  = CookingToday.find(item_id)
            if cooking_today.not_orderable?
              session[:cart] = nil
              redirect_to("/mobile", alert: "Sorry! There were some menus in your cart that we can't serve right now.") and return
            end
            food_item = cooking_today.food_item
            if !@order.blank?
              menu = OrderedMenu.create(:order_id => @order.id,:dish_id => food_item.id, :cooking_today_id => cooking_today.id,
                                        :cheff_id => food_item.cheff.id, :quantity => item_attr['quantity'],
                                        :rate => item_attr['price'])
              @coupon = Coupon.find_by_id(item_attr["coupon_id"])
              if !@coupon.blank?
                used_count = @coupon.no_of_used_coupons.to_i + 1
                Coupon.where(:id => item_attr["coupon_id"]).update_all(:no_of_used_coupons => used_count)
                @coupon.hola_users << hola_user
                @coupon_id = item_attr["coupon_id"]
              else
                @coupon_id = 0
              end
            end
          end
        end
      end
      cookies.signed[:user_mobile] = {value: hola_user.phoneNumber, expires: 1.year.from_now} if hola_user
      mrp = OrderedMenu.calculate_mrp(@order)
      if !@coupon.blank?
        discount = @coupon.flat.blank? ? @coupon.percentage : @coupon.flat
        discount_type = @coupon.flat.blank? ? "percentage" : "flat"
        discount_amount = (@discount_type=='flat') ? discount : Coupon.calculate_percentage(mrp, discount)
      else
        discount_amount = 0
      end
      @order.update_attributes(:total => (OrderedMenu.calculate_total(@order, discount_amount, meal_type_length)), :coupon_id => @coupon_id, :mrp => mrp)
      @footer = "false"
      #@@cart_items = view_context.collect_items(session[:cart])

      respond_to do |format|
        format.html {render :layout => 'application'}
      end
    end
  end

  def order_confirm
    @footer = "false"
    @order = Order.find(params[:order_id])
    @order.update_attributes(order_status: "Confirmed", payment_mode: "On Delivery")
    session[:cart] = [] #if @order.
    if ["swipe_on_delivery", "cash_on_delivery"].include? params[:payment_mode]
      @order.ordered_menus.each do |ordered_menu|
        cooking_today  = ordered_menu.cooking_today
        # raise cooking_today.inspect
        if cooking_today.not_orderable?
          session[:cart] = nil
          redirect_to "/mobile", alert: "Sorry! There were some menus in your cart that we can't serve right now." and return
        end
        cooking_today.update_attributes(:ordered => (cooking_today.ordered.to_i + ordered_menu.quantity.to_i)) if cooking_today
      end
    end
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def submit_payment_form
    @order = Order.find(params[:orderId])
    @order.update_attribute(:payment_mode, "Online")
    @paymentMode = params[:paymentMode]
    @flag=false
    @secSignature=''
    @reqtime = Time.now.to_f*1000
    ct = CitrusLib.new
    ct.setApiKey(Settings.citrus_gateway.apikey,Settings.citrus_gateway.gateway_env)
    data=Settings.citrus_gateway.pmturl+"#{@order.total}#{@order.id}INR"
    @secSignature = ct.getHmac(data)
    @action=ct.getCpUrl+Settings.citrus_gateway.pmturl
    @flag=true
    respond_to do |format|
      format.js
    end
  end

  def callback 	# to be called by Citrus to post response
    @data=''
    @action=''
    @status=false
    @statusmsg="Forged access"
    params.delete("controller")
    params.delete("action")
    @txstatus = params[:TxStatus]
    @order = Order.find(params[:TxId])
    if params[:TxStatus] == "SUCCESS"
      @order.update_attributes(:order_status => "Confirmed", :payment_status => "Paid", :payment_gateway_response => params,
                               :firstName => params[:firstName],:lastName => params[:lastName],:email => params[:email],
                               :addressStreet1=>params[:addressStreet1],:addressStreet2=>params[:addressStreet2],
                               :addressCity=>params[:addressCity], :addressState=>params[:addressState],
                               :addressCountry=>params[:addressCountry],:addressZip=>params[:addressZip])
      # @@cart_items.each do |item_id, quantity|
      #   cooking_today  = CookingToday.find(item_id)
      #   cooking_today.update_attributes(:ordered => (cooking_today.ordered.to_i + quantity.to_i)) if cooking_today
      # end
      @order.ordered_menus.each do |ordered_menu|
        cooking_today  = ordered_menu.cooking_today
        cooking_today.update_attributes(:ordered => (cooking_today.ordered.to_i + ordered_menu.quantity.to_i)) if cooking_today
      end

      @order.ordered_menus.each do |menu|
        food_item = FoodItem.find(menu.dish_id)
        food_item.update_attributes(:dish_served => (food_item.dish_served.to_i + menu.quantity.to_i)) if food_item
      end
    else
      @order.update_attributes(:payment_status => "Payment Gateway Failed", :payment_gateway_response => params) unless @txstatus == 'CANCELED'
    end

    if @txstatus == 'CANCELED'
      @statusmsg=@txmsg
      session[:cart] = @order.build_session
      @order.update_attributes(:payment_status => "User Canceled", :payment_gateway_response => params)
      render "payment_gateway", :layout => 'application'
    elsif @txstatus == 'SUCCESS'
      ct = CitrusLib.new
      ct.setApiKey(Settings.citrus_gateway.apikey,Settings.citrus_gateway.gateway)
      secSignature = ct.getHmac(@data)
      if secSignature != @signature    # post signature verification to prevent forgery
        @status = false
      else
        @statusmsg = 'Verified Response'
      end
      respond_to do |format|
        format.html {render 'order_confirm',:layout => 'application'}
      end
    else
      render "payment_gateway", :layout => 'application'
    end
  end


  def create_signature_order
    @signature_dish = FoodItem.find(params[:dish_id])
    date_diff = Order.check_signature_order_delivery_date(params[:order][:date])

    min_order_quantity = @signature_dish.meal_info.minimum_order_qty
    if date_diff < @signature_dish.meal_info.preorder_time
    @error_msg = "Delivery date should be greater than #{@signature_dish.meal_info.preorder_time} days."
    elsif params[:order][:quantity].to_i < min_order_quantity
      @error_msg = "Quantity should not be less than #{min_order_quantity}."
    elsif Date.today.strftime("%d/%m/%y") == params[:order][:date] && params[:order][:from_time] < DateTime.now.strftime("%I:%M%p")
      @error_msg = "From time should not less than current time."
    elsif params[:order][:from_time] >= params[:order][:upto_time]
      @error_msg = "From time should be less than upto time."
    else
     order = Order.create(:date => params[:order][:date], :from_time => params[:order][:from_time],
                          :upto_time => params[:order][:upto_time], :order_type => "Pick Up")
     if order
       Order.create_signature_menus(order, @signature_dish, params[:order])
     end
    end
    respond_to do |format|
      format.js
    end
  end

  def show_invoice
    @order = Order.find(params[:order_id])
    respond_to do |format|
      format.html {render :partial => "cms/orders/invoice"}
    end
  end

  def email_invoice
    email_details = {:recepients => params[:email_to], :subject => "HolaChef Invoice Details"}
    if params[:email_to].present? && Notifier.email_invoice_details(email_details, params[:order_id]).deliver
      flash[:notice] = "Invoice has been sent to your email address."
      redirect_to "/mobile"
    else
      flash[:error] = "Could not send invoice."
      redirect_to "/order-confirm/#{params[:order_id]}"
    end
  end
end
