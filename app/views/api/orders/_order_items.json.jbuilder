json.id order.id
json.customer_name order.hola_user.blank? ? order.name : order.hola_user.name
json.customer_contact_number order.hola_user.blank? ?  order.phone_no : order.try(:hola_user).try(:phoneNumber)
json.address do
  json.address_line_1 order.addressStreet1
  json.address_line_2 order.addressStreet2
  json.address_city order.addressCity
  json.address_state order.addressState
  json.pincode order.addressZip
  json.landmark order.landmark
end
json.order_items  order.ordered_menus do |menu|
  json.menu_item_id menu.id
  json.dish_name menu.food_item.meal_info.name
  json.quantity menu.quantity
  json.rate     menu.rate
  json.menu_item_total (menu.quantity * menu.rate)
  json.order_status menu.order_status
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
json.payment_mode order.payment_mode

json.runner do
  json.id order.runner_id
  json.name order.runner.try(:name)
  json.phone order.runner.try(:phone)
  json.address order.runner.try(:address)
end
json.confirmed_at order.confirmed_at
json.dispatched_at order.dispatched_at
json.delivered_at order.delivered_at
json.created_at order.created_at
