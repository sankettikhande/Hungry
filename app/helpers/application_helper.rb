module ApplicationHelper
  def qty_left(menu)
    qty = menu.quantity - menu.ordered if menu.quantity
    return  qty
  end

  def collect_session_items(cart)
    today = {}
    cart.each do |item|
      item.each do |item_id, item_attr|
        today[item_id.to_i] = item_attr['quantity'].to_i
      end
    end
    return today
  end
end
