class OrderedMenusController < ApplicationController
  def checkout
    @hola_user = hola_current_user
    categories = []
    
    if session[:cart].blank?
      redirect_to("/mobile") and return
    end

    session[:cart].each do |cart_item|
      cart_item.each do |key, value|
            @categories = categories << value["category"]
      end
    end
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
            if discount_type== "flat"
              @discount_amount = discount
            else
              @discount_amount = Coupon.calculate_percentage(params[:total_amount],discount)
            end
            puts @discount_amount
            @msg ="Valid coupon code"
            @paid_amount = params[:total_amount].to_i -  @discount_amount.to_i
            session[:discountAmount] = @discount_amount
            session[:paidAmount] = params[:total_amount].to_i
            session[:netAmount] = @paid_amount
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
