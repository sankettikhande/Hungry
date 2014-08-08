class PartyOrdersController < ApplicationController
  def index
    @party_order = PartyOrder.new
  end

  def create
    party_order = PartyOrder.new(params[:party_order])
    party_order.save
    flash[:notice] = "Your order successfully placed."
    redirect_to party_orders_path
  end
end
