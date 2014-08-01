# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140731132033) do

  create_table "categories", :force => true do |t|
    t.integer  "category_type_id"
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "category_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chef_coordinates", :force => true do |t|
    t.integer  "cheff_id"
    t.string   "name"
    t.text     "address_line_1"
    t.text     "address_line_2"
    t.string   "locality"
    t.string   "landmark"
    t.string   "city"
    t.integer  "zip"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "contact_mobile"
    t.string   "contact_landline"
    t.string   "contact_email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "chef_profiles", :force => true do |t|
    t.integer  "cheff_id"
    t.text     "about_me"
    t.text     "why_i_love_cooking"
    t.text     "people_places_that_inspire_my_food"
    t.text     "best_compliment"
    t.text     "why_do_i_want_to_join_hola"
    t.string   "facebook_handle"
    t.string   "twitter_handle"
    t.text     "banners"
    t.text     "brand_represented"
    t.text     "brand_info"
    t.text     "brand_banner"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "brand_logo_file_name"
    t.string   "brand_logo_content_type"
    t.integer  "brand_logo_file_size"
    t.datetime "brand_logo_updated_at"
  end

  create_table "cheff_cuisine_geographies", :force => true do |t|
    t.integer  "cuisine_geography_id"
    t.integer  "cheff_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "cheff_cuisine_styles", :force => true do |t|
    t.integer  "cheff_id"
    t.integer  "cuisine_style_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "cheff_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.string   "name"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "hotel_name"
    t.string   "address"
  end

  create_table "cheffs", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",     :default => 0
    t.string   "name"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "published",        :default => false
    t.boolean  "deleted",          :default => false
    t.boolean  "archived",         :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "hotel_name"
    t.string   "address"
    t.date     "chef_acquired_on"
    t.string   "ancestry"
  end

  add_index "cheffs", ["ancestry"], :name => "index_cheffs_on_ancestry"

  create_table "cms_attachment_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.string   "data_file_path"
    t.string   "file_location"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "data_file_name"
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "data_fingerprint"
    t.string   "attachable_type"
    t.string   "attachment_name"
    t.integer  "attachable_id"
    t.integer  "attachable_version"
    t.string   "cardinality"
  end

  add_index "cms_attachment_versions", ["original_record_id"], :name => "index_attachment_versions_on_original_record_id"

  create_table "cms_attachments", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",       :default => 0
    t.string   "data_file_path"
    t.string   "file_location"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "data_file_name"
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "data_fingerprint"
    t.string   "attachable_type"
    t.string   "attachment_name"
    t.integer  "attachable_id"
    t.integer  "attachable_version"
    t.string   "cardinality"
  end

  create_table "connectors", :force => true do |t|
    t.integer  "page_id"
    t.integer  "page_version"
    t.integer  "connectable_id"
    t.string   "connectable_type"
    t.integer  "connectable_version"
    t.string   "container"
    t.integer  "position"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "connectors", ["connectable_type"], :name => "index_connectors_on_connectable_type"
  add_index "connectors", ["connectable_version"], :name => "index_connectors_on_connectable_version"
  add_index "connectors", ["page_id"], :name => "index_connectors_on_page_id"
  add_index "connectors", ["page_version"], :name => "index_connectors_on_page_version"

  create_table "content_type_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "content_types", :force => true do |t|
    t.string   "name"
    t.integer  "content_type_group_id"
    t.integer  "priority",              :default => 2
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "content_types", ["content_type_group_id"], :name => "index_content_types_on_content_type_group_id"
  add_index "content_types", ["name"], :name => "index_content_types_on_name"

  create_table "cooking_today_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.integer  "cheff_id"
    t.integer  "dish_id"
    t.integer  "quantity",           :default => 0
    t.integer  "ordered",            :default => 0
    t.date     "date"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "name"
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "cooking_todays", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",  :default => 0
    t.integer  "cheff_id"
    t.integer  "dish_id"
    t.integer  "quantity",      :default => 0
    t.integer  "ordered",       :default => 0
    t.date     "date"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "name"
    t.boolean  "published",     :default => false
    t.boolean  "deleted",       :default => false
    t.boolean  "archived",      :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "food_item_id"
  end

  create_table "cuisine_geographies", :force => true do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "deleted"
    t.boolean  "archived"
    t.boolean  "published"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "cuisine_styles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "deleted"
    t.boolean  "archived"
    t.boolean  "published"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "dish_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.string   "name"
    t.boolean  "if_signature"
    t.integer  "portions"
    t.integer  "days_notice"
    t.text     "information"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "price"
    t.string   "dish_type"
    t.integer  "cooking_time"
    t.integer  "serves"
    t.string   "cuisine"
    t.string   "tags"
    t.string   "category"
    t.string   "cooking_equipment"
    t.string   "treatment"
  end

  create_table "dynamic_view_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.string   "type"
    t.string   "name"
    t.string   "format"
    t.string   "handler"
    t.text     "body"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "dynamic_views", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",  :default => 0
    t.string   "type"
    t.string   "name"
    t.string   "format"
    t.string   "handler"
    t.text     "body"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "published",     :default => false
    t.boolean  "deleted",       :default => false
    t.boolean  "archived",      :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "email_messages", :force => true do |t|
    t.string   "sender"
    t.text     "recipients"
    t.text     "subject"
    t.text     "cc"
    t.text     "bcc"
    t.text     "body"
    t.string   "content_type"
    t.datetime "delivered_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "file_block_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.string   "type"
    t.string   "name"
    t.integer  "attachment_id"
    t.integer  "attachment_version"
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "file_block_versions", ["original_record_id"], :name => "index_file_block_versions_on_original_record_id"
  add_index "file_block_versions", ["version"], :name => "index_file_block_versions_on_version"

  create_table "file_blocks", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",       :default => 0
    t.string   "type"
    t.string   "name"
    t.integer  "attachment_id"
    t.integer  "attachment_version"
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "file_blocks", ["deleted"], :name => "index_file_blocks_on_deleted"
  add_index "file_blocks", ["type"], :name => "index_file_blocks_on_type"

  create_table "food_item_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.date     "meal_acquired_date"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "name"
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "food_items", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",       :default => 0
    t.date     "meal_acquired_date"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "name"
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "cheff_id"
    t.boolean  "if_signature",       :default => false
    t.boolean  "if_recipe",          :default => false
    t.integer  "dish_served",        :default => 0
  end

  create_table "group_permissions", :force => true do |t|
    t.integer "group_id"
    t.integer "permission_id"
  end

  add_index "group_permissions", ["group_id", "permission_id"], :name => "index_group_permissions_on_group_id_and_permission_id"
  add_index "group_permissions", ["group_id"], :name => "index_group_permissions_on_group_id"
  add_index "group_permissions", ["permission_id"], :name => "index_group_permissions_on_permission_id"

  create_table "group_sections", :force => true do |t|
    t.integer "group_id"
    t.integer "section_id"
  end

  add_index "group_sections", ["group_id"], :name => "index_group_sections_on_group_id"
  add_index "group_sections", ["section_id"], :name => "index_group_sections_on_section_id"

  create_table "group_type_permissions", :force => true do |t|
    t.integer "group_type_id"
    t.integer "permission_id"
  end

  create_table "group_types", :force => true do |t|
    t.string   "name"
    t.boolean  "guest",      :default => false
    t.boolean  "cms_access", :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "group_types", ["cms_access"], :name => "index_group_types_on_cms_access"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "group_type_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "groups", ["code"], :name => "index_groups_on_code"
  add_index "groups", ["group_type_id"], :name => "index_groups_on_group_type_id"

  create_table "hola_user_addresses", :force => true do |t|
    t.string   "address"
    t.integer  "hola_user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "address_type"
    t.string   "name"
    t.string   "building_name"
    t.string   "street"
    t.string   "city"
    t.string   "pin"
    t.string   "landmark"
    t.boolean  "default",       :default => false
  end

  create_table "hola_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phoneNumber"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "html_block_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.string   "name"
    t.text     "content",            :limit => 16777215
    t.boolean  "published",                              :default => false
    t.boolean  "deleted",                                :default => false
    t.boolean  "archived",                               :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  add_index "html_block_versions", ["original_record_id"], :name => "index_html_block_versions_on_original_record_id"
  add_index "html_block_versions", ["version"], :name => "index_html_block_versions_on_version"

  create_table "html_blocks", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",                      :default => 0
    t.string   "name"
    t.text     "content",       :limit => 16777215
    t.boolean  "published",                         :default => false
    t.boolean  "deleted",                           :default => false
    t.boolean  "archived",                          :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "html_blocks", ["deleted"], :name => "index_html_blocks_on_deleted"

  create_table "ingredients", :force => true do |t|
    t.integer  "dish_id"
    t.string   "ingredient_name"
    t.string   "quantity"
    t.string   "special_remarks"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "unit"
    t.integer  "sub_menu_id"
    t.integer  "recipe_id"
  end

  create_table "link_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.string   "name"
    t.string   "url"
    t.boolean  "new_window",         :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "links", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",   :default => 0
    t.string   "name"
    t.string   "url"
    t.boolean  "new_window",     :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "published",      :default => false
    t.boolean  "deleted",        :default => false
    t.boolean  "archived",       :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "latest_version"
  end

  create_table "meal_infos", :force => true do |t|
    t.integer  "food_item_id"
    t.string   "name"
    t.text     "description"
    t.integer  "preorder_time"
    t.integer  "portion_size"
    t.integer  "minimum_order_qty"
    t.integer  "hola_buy_price"
    t.integer  "hola_sell_price"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "my_favorite_chefs", :force => true do |t|
    t.integer  "cheff_id"
    t.integer  "hola_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "my_favorite_recipes", :force => true do |t|
    t.integer  "food_item_id"
    t.integer  "hola_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "order_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.string   "phone_no"
    t.text     "address"
    t.integer  "total"
    t.datetime "date"
    t.string   "order_status"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "name"
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "ordered_menu_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.integer  "order_id"
    t.integer  "cheff_id"
    t.integer  "dish_id"
    t.integer  "quantity"
    t.integer  "rate"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "name"
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "ordered_menus", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",  :default => 0
    t.integer  "order_id"
    t.integer  "cheff_id"
    t.integer  "dish_id"
    t.integer  "quantity"
    t.integer  "rate"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "name"
    t.boolean  "published",     :default => false
    t.boolean  "deleted",       :default => false
    t.boolean  "archived",      :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",             :default => 0
    t.string   "phone_no"
    t.text     "address"
    t.integer  "total"
    t.date     "date"
    t.string   "order_status"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "name"
    t.boolean  "published",                :default => false
    t.boolean  "deleted",                  :default => false
    t.boolean  "archived",                 :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "order_type"
    t.time     "from_time"
    t.time     "upto_time"
    t.text     "payment_gateway_response"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "email"
    t.string   "addressStreet1"
    t.string   "addressStreet2"
    t.string   "addressCity"
    t.string   "addressState"
    t.string   "addressCountry"
    t.string   "addressZip"
  end

  create_table "page_route_options", :force => true do |t|
    t.integer  "page_route_id"
    t.string   "type"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "page_routes", :force => true do |t|
    t.string   "name"
    t.string   "pattern"
    t.integer  "page_id"
    t.text     "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "page_versions", :force => true do |t|
    t.integer  "original_record_id"
    t.integer  "version"
    t.string   "name"
    t.string   "title"
    t.string   "path"
    t.string   "template_file_name"
    t.text     "description"
    t.text     "keywords"
    t.string   "language"
    t.boolean  "cacheable",          :default => false
    t.boolean  "hidden",             :default => false
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.string   "version_comment"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "page_versions", ["original_record_id"], :name => "index_page_versions_on_original_record_id"

  create_table "pages", :force => true do |t|
    t.integer  "version"
    t.integer  "lock_version",       :default => 0
    t.string   "name"
    t.string   "title"
    t.string   "path"
    t.string   "template_file_name"
    t.text     "description"
    t.text     "keywords"
    t.string   "language"
    t.boolean  "cacheable",          :default => false
    t.boolean  "hidden",             :default => false
    t.boolean  "published",          :default => false
    t.boolean  "deleted",            :default => false
    t.boolean  "archived",           :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "latest_version"
  end

  add_index "pages", ["deleted"], :name => "index_pages_on_deleted"
  add_index "pages", ["path"], :name => "index_pages_on_path"
  add_index "pages", ["version"], :name => "index_pages_on_version"

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "full_name"
    t.string   "description"
    t.string   "for_module"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pictures", :force => true do |t|
    t.integer  "picturable_id"
    t.string   "picturable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "portlet_attributes", :force => true do |t|
    t.integer "portlet_id"
    t.string  "name"
    t.text    "value"
  end

  add_index "portlet_attributes", ["portlet_id"], :name => "index_portlet_attributes_on_portlet_id"

  create_table "portlets", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.boolean  "archived",      :default => false
    t.boolean  "deleted",       :default => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "portlets", ["name"], :name => "index_portlets_on_name"

  create_table "prepration_steps", :force => true do |t|
    t.integer  "dish_id"
    t.text     "steps"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "sub_menu_id"
    t.integer  "recipe_id"
  end

  create_table "recipes", :force => true do |t|
    t.integer  "food_item_id"
    t.text     "garnishing_tips"
    t.text     "serving_tips"
    t.text     "storage_instructions"
    t.string   "shelf_life"
    t.string   "equipment_required"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "preparation_time"
    t.integer  "total_time"
    t.integer  "servings"
    t.boolean  "if_signature",         :default => false
    t.boolean  "if_recipe",            :default => false
    t.string   "cuisine"
    t.string   "category"
    t.string   "treatment"
    t.string   "dish_type"
  end

  create_table "redirects", :force => true do |t|
    t.string   "from_path"
    t.string   "to_path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "redirects", ["from_path"], :name => "index_redirects_on_from_path"

  create_table "reviews", :force => true do |t|
    t.integer  "food_item_id"
    t.date     "review_date"
    t.string   "reviewer"
    t.text     "review"
    t.integer  "ratings",      :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "section_nodes", :force => true do |t|
    t.string   "node_type"
    t.integer  "node_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
  end

  add_index "section_nodes", ["ancestry"], :name => "index_section_nodes_on_ancestry"
  add_index "section_nodes", ["node_type"], :name => "index_section_nodes_on_node_type"

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.boolean  "root",       :default => false
    t.boolean  "hidden",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "sections", ["path"], :name => "index_sections_on_path"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.boolean  "the_default"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sub_menus", :force => true do |t|
    t.integer  "dish_id"
    t.string   "title"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "deleted"
    t.boolean  "archived"
    t.boolean  "published"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "name"
    t.integer  "recipe_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count", :default => 0
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "tasks", :force => true do |t|
    t.integer  "assigned_by_id"
    t.integer  "assigned_to_id"
    t.integer  "page_id"
    t.text     "comment"
    t.date     "due_date"
    t.datetime "completed_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "tasks", ["assigned_to_id"], :name => "index_tasks_on_assigned_to_id"
  add_index "tasks", ["completed_at"], :name => "index_tasks_on_completed_at"
  add_index "tasks", ["page_id"], :name => "index_tasks_on_page_id"

  create_table "temporary_homes", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tips", :force => true do |t|
    t.integer  "dish_id"
    t.text     "tips"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_group_memberships", :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  add_index "user_group_memberships", ["group_id"], :name => "index_user_group_memberships_on_group_id"
  add_index "user_group_memberships", ["user_id"], :name => "index_user_group_memberships_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "first_name",                :limit => 40
    t.string   "last_name",                 :limit => 40
    t.string   "email",                     :limit => 40
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expires_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "reset_token"
  end

  add_index "users", ["expires_at"], :name => "index_users_on_expires_at"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
