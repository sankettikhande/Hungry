json.id order.id
json.customer_name order.hola_user.blank? ? order.name : order.hola_user.name
json.customer_contact_number order.hola_user.blank? ?  order.phone_no : order.try(:hola_user).try(:phoneNumber)

json.address do
  json.area order.delivery_address.try(:area)
  json.sub_area order.delivery_address.try(:sub_area)
end

json.order_items  order.ordered_menus do |menu|
  json.meal_type menu.cooking_today.meal_type if menu.cooking_today
end

json.order_status order.order_status
json.order_progress order.order_status_history_string
json.delivery_slot order.delivery_slot
json.payment_mode (order.parent_order.blank? ? order.payment_mode : order.parent_order.payment_mode)

json.confirmed_at order.confirmed_at.strftime("%H:%M") if !order.confirmed_at.blank?
json.dispatched_at order.dispatched_at
json.delivered_at order.delivered_at
json.since_confirmed order.confirmed_at ? ((Time.now - order.confirmed_at)/60).floor : nil
json.created_at order.created_at
