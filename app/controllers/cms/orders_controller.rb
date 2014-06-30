class Cms::OrdersController < Cms::ContentBlockController
  skip_before_filter :login_required,:cms_access_required, :only => [:set_cart, :payment_gateway,:order_confirm,
                                                                     :remove_from_cart, :create_signature_order, :callback,
                                                                     :submit_payment_form]
  def set_cart
    session[:cart] = [] if session[:cart].nil?
    cart_ids = []
    cart_ids = session[:cart].collect{|item| item.keys}.flatten
    if cart_ids.include?(params[:item_id])
       session[:cart].each do |item|
         session[:cart].delete(item) if item.keys.flatten.include?(params[:item_id])
       end
       session[:cart] << ({params[:item_id]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date], 'dish_name' => params[:dish_name] }})
    else
      session[:cart] << ({params[:item_id]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date], 'dish_name' => params[:dish_name] }})
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

  def payment_gateway
    @title = "Select Payment Method"
    @order = Order.create(:date => Time.now, :order_status => "Created", :order_type => 'Regular')
    session[:cart].each do |item|
      item.each do |item_id, item_attr|
        cooking_today  = CookingToday.find(item_id)
        dish = cooking_today.dish
        if @order
          menu = OrderedMenu.create(:order_id => @order.id,:dish_id => dish.id,
                                    :cheff_id => dish.cheff.id, :quantity => item_attr['quantity'],
                                    :rate => item_attr['price'])

        end
      end
    end
    @order.update_attributes(:total => (OrderedMenu.calculate_total(@order)), :order_status => "Waiting for Payment",
                             :name=>params[:orders][:name], :address=>params[:orders][:address],
                             :phone_no=>params[:orders][:phone_no])
    #session[:cart] = []
    @footer = "false"


    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def order_confirm
    @title = "Thank You!"
    @footer = "false"
    @order = Order.find(params[:order_id])


    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def submit_payment_form
    @order = Order.find(params[:orderId])
    @paymentMode = params[:paymentMode]
    @flag=false
    @secSignature=''
    @reqtime = Time.now.to_f*1000
    ct = CitrusLib.new
    ct.setApiKey($apikey,$gateway)
    data=$pmturl+"#{@order.total}#{@order.id}INR"
    @secSignature = ct.getHmac(data)
    $action=ct.getCpUrl+$pmturl
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
    @order = Order.find(params[:TxId])
    if params[:TxStatus] == "SUCCESS"
      @order.update_attributes(:order_status => "Payment Done", :payment_gateway_response => params,
                               :firstName => params[:firstName],:lastName => params[:lastName],:email => params[:email],
                               :addressStreet1=>params[:addressStreet1],:addressStreet2=>params[:addressStreet2],
                               :addressCity=>params[:addressCity], :addressState=>params[:addressState],
                               :addressCountry=>params[:addressCountry],:addressZip=>params[:addressZip])
      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          cooking_today  = CookingToday.find(item_id)
          cooking_today.update_attributes(:ordered => (cooking_today.ordered.to_i + item_attr['quantity'].to_i))
        end
      end
      session[:cart] = []
    else
      @order.update_attributes(:payment_gateway_response => params, :firstName => params[:firstName],
                               :lastName => params[:lastName],:email => params[:email],
                               :addressStreet1=>params[:addressStreet1],:addressStreet2=>params[:addressStreet2],
                               :addressCity=>params[:addressCity], :addressState=>params[:addressState],
                               :addressCountry=>params[:addressCountry],:addressZip=>params[:addressZip])
    end
    @status=true
    if @status==true
      if @txstatus == 'CANCELED'
        @statusmsg=@txmsg
      elsif @txstatus == 'SUCCESS'
        ct = CitrusLib.new
        ct.setApiKey($apikey,$gateway)
        secSignature = ct.getHmac(@data)
        if secSignature != @signature    # post signature verification to prevent forgery
          @status = false
        else
          @statusmsg = 'Verified Response'
        end
      end
    end

    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def create_signature_order
    @signature_dish = Dish.find(params[:dish_id])
    order = Order.create(:date => params[:order][:date], :from_time => params[:order][:from_time],
                         :upto_time => params[:order][:upto_time], :order_type => "Pick Up")
    if order
      Order.create_signature_menus(order, @signature_dish, params[:order])
    end
    respond_to do |format|
      format.js
    end
  end
end
class CitrusLib

  def setApiKey (key,env)
    @@apiKey = key
    @@env = env

    case @@env
      when 'sandbox'
        @@apiUrl = @@SANDBOX_API_URL
        @@cpUrl = @@SANDBOX_PMT_URL
      when 'staging'
        @@apiUrl = @@STAGING_API_URL
        @@cpUrl = @@STAGING_PMT_URL
      when 'production'
        @@apiUrl = @@PRODUCTION_API_URL
        @@cpUrl = @@PRODUCTION_PMT_URL
    end

  end

  def getApiUrl()
    return @@apiUrl
  end

  def getCpUrl()
    return @@cpUrl
  end

  def getHmac(data)
    digest = OpenSSL::Digest::Digest.new('sha1')
    sig=OpenSSL::HMAC.hexdigest(digest, @@apiKey, data)
    return sig
  end

  @@SANDBOX_API_URL='https://sandboxadmin.citruspay.com/api/v1/txn/'
  @@SANDBOX_PMT_URL='https://sandbox.citruspay.com/'

  @@STAGING_API_URL='https://stgadmin.citruspay.com/api/v1/txn/'
  @@STAGING_PMT_URL='https://stg.citruspay.com/'

  @@PRODUCTION_API_URL='https://admin.citruspay.com/api/v1/txn/'
  @@PRODUCTION_PMT_URL='https://www.citruspay.com/'

  @@apiKey=''
  @@env=''
  @@apiUrl=''
  @@cpUrl=''

end