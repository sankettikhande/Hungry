json.id order.id
json.customer_name order.hola_user.blank? ? order.name : order.hola_user.name
json.customer_contact_number order.hola_user.blank? ?  order.phone_no : order.try(:hola_user).try(:phoneNumber)
json.address do
  json.address_line_1 order.delivery_address.try(:building_name)
  json.address_line_2 order.delivery_address.try(:street)
  json.address_city order.delivery_address.try(:city)
  json.address_state ""
  json.pincode order.delivery_address.try(:pin)
  json.landmark order.delivery_address.try(:landmark)
  json.area order.delivery_address.try(:area)
  json.sub_area order.delivery_address.try(:sub_area)
end
json.order_items  order.ordered_menus do |menu|
  json.menu_item_id menu.id
  json.dish_name menu.food_item.meal_info.name
  json.quantity menu.quantity
  json.rate     menu.rate
  json.menu_item_total (menu.quantity * menu.rate)
  json.order_status menu.order_status
  json.meal_type menu.cooking_today.meal_type if menu.cooking_today
  json.cheff menu.cheff.name
end

json.bill_amount order.bill_amount
json.order_status order.order_status
if order.reordered?
  json.reorder_id order.reorder_id
end
unless order.original_order_id.blank?
  json.original_order_id order.original_order_id
end
json.order_progress order.order_status_history_string
json.payment_status order.payment_status
json.payment_value order.total
json.couponID order.coupon_id
json.deliverySlot order.delivery_slot
json.payment_mode (order.parent_order.blank? ? order.payment_mode : order.parent_order.payment_mode)

json.runner do
  json.id order.runner_id
  json.name order.runner.try(:name)
  json.phone order.runner.try(:phone)
  json.address order.runner.try(:address)
end
json.confirmed_at order.confirmed_at
json.dispatched_at order.dispatched_at
json.delivered_at order.delivered_at
json.since_confirmed order.confirmed_at ? ((Time.now - order.confirmed_at)/60).floor : nil
json.created_at order.created_at
json.order_type order.order_type
