module ApplicationHelper
  def qty_left(menu)
    qty = menu.quantity - menu.ordered if menu.quantity
    return  qty
  end
end
