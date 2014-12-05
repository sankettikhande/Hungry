class OrderedMenusController < ApplicationController

  # Added for removal of added coupon on navigation issue pre-order orders issue
  # On 18/11/2014 By Pradnya Kulkarni 
  # Contact: pradnya@sodelsolutions.com
  before_filter :set_cache_buster

  before_filter :check_inventory, only: [:add_address]

  def checkout
    @hola_user = hola_current_user
    categories, @discount = [], 0
    
    if session[:cart].blank?
      redirect_to("/mobile") and return
    end

    session[:cart].each do |cart_item|
      cart_item.each do |key, value|
            @categories = categories << value["category"]
      end
    end

    # Added for displaying orders in Ascending order of date in case of pre-order orders issue
    # On 17/11/2014 By Pradnya Kulkarni 
    # Contact: pradnya@sodelsolutions.com
    # session[:cart] = session[:cart].sort_by { |h| h.first.second.first.second }

    # Added for removal of added coupon on navigation issue pre-order orders issue
    @show_values = false
    if session[:cart]
      @show_values = true        
    end
    
    @total, @discount = 0, 0
    if !session[:cart].nil?
      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          @total = @total + (item_attr['quantity'].to_i * item_attr['price'].to_i)
        end
      end
    end
    calculate_order_amounts

    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def order_payment

  end

  def check_coupon_code
    if !params[:coupon_code].blank? && !params[:total_amount].blank?
      coupon = Coupon.find_by_coupon_code(params[:coupon_code])
      if coupon.blank?
        @msg = "Invalid coupon code"
      else
        ## check coupon validity added check only for 1U1T
        @msg = coupon.check_coupons_validity(hola_current_user.id)
        if @msg.blank?
          discount = coupon.flat.blank? ? coupon.percentage : coupon.flat
          discount_type = coupon.flat.blank? ? "percentage" : "flat"
          if !discount.blank?
            if discount_type == "flat"
              @discount_amount = discount
            else
              @discount_amount = Coupon.calculate_percentage(params[:total_amount],discount)
            end
            @msg ="Valid coupon code"
            @paid_amount = params[:total_amount].to_i -  @discount_amount.to_i
            session[:discountAmount] = @discount_amount
            session[:paidAmount] = params[:total_amount].to_i
            session[:netAmount] = @paid_amount

            # Added for removal of added coupon on navigation issue pre-order orders issue
            session[:coupon_code] = params[:coupon_code]

            session[:cart].each do |cart_item|
              cart_item.each do |key, value|
                value["discount_amount"] = @discount_amount
                value["coupon_id"]= coupon.id
              end
            end
          end
        end
      end
      respond_to do |format|
        format.js
      end
    end

  end

  def get_address_by_type
    hola_user = hola_current_user
    @adds = hola_user.hola_user_addresses.where(address_type: params[:address_type]).first
  end
end
