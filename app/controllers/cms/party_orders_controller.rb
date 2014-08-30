class Cms::PartyOrdersController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:party_orders, :create_party_orders]

  def party_orders
    @party_order = PartyOrder.new
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def create_party_orders
    @party_order = PartyOrder.new(params[:party_order])
    if @party_order.save
      redirect_to "/party_orders", notice: "Your order successfully placed."
    else
      render 'party_orders'
    end
  end
end
