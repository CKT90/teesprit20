class StructureUpdate < ActiveRecord::Migration[6.0]
  def change
  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "images", force: :cascade do |t|
    t.integer "position"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.integer "variant_id"
    t.index ["product_id"], name: "index_images_on_product_id"
    t.index ["variant_id"], name: "index_images_on_variant_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "product_id"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.integer "order_id"
    t.integer "variant_id"
    t.string "selection"
    t.decimal "final_cost", precision: 8, scale: 2
    t.decimal "final_price", precision: 8, scale: 2
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
    t.index ["variant_id"], name: "index_line_items_on_variant_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "subject"
    t.text "content"
    t.string "sender_id"
    t.string "sender_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "option_types", force: :cascade do |t|
    t.string "name"
    t.string "presentation"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hidden", default: false
    t.boolean "color", default: false
  end

  create_table "option_value_variants", force: :cascade do |t|
    t.integer "variant_id"
    t.integer "option_value_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hidden", default: false
    t.index ["option_value_id"], name: "index_option_value_variants_on_option_value_id"
    t.index ["variant_id"], name: "index_option_value_variants_on_variant_id"
  end

  create_table "option_values", force: :cascade do |t|
    t.integer "position"
    t.string "name"
    t.string "presentation"
    t.integer "option_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value_position"
    t.boolean "hidden", default: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "email"
    t.string "pay_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "number"
    t.integer "payment_type_cd", default: 0
    t.integer "payment_status_cd", default: 0
    t.integer "order_status_cd", default: 0
    t.integer "shipment_status_cd", default: 0
    t.datetime "payment_confirmation_date"
    t.text "payment_remarks"
    t.text "shipment_remarks"
    t.datetime "shipment_confirmation_date"
    t.string "contact_number"
    t.integer "states_cd"
    t.boolean "hidden", default: false
    t.string "states"
    t.integer "delivery_cost"
    t.decimal "grand_total_price", precision: 8, scale: 2
    t.string "order_mail"
    t.string "paypal_transaction_id"
    t.string "stripe_transaction_id"
    t.index ["user_id", "created_at"], name: "index_orders_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_notifications", force: :cascade do |t|
    t.text "params"
    t.integer "cart_id"
    t.string "status"
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoice_id"
  end

  create_table "product_option_types", force: :cascade do |t|
    t.integer "option_type_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hidden", default: false
    t.index ["option_type_id"], name: "index_product_option_types_on_option_type_id"
    t.index ["product_id"], name: "index_product_option_types_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "number"
    t.datetime "available_on"
    t.datetime "discontinue_on"
    t.boolean "hidden", default: false
    t.integer "state_cd", default: 0
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.integer "product_id"
    t.index ["product_id"], name: "index_properties_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.text "address"
    t.string "contact_number"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "variant_images", force: :cascade do |t|
    t.integer "variant_id"
    t.integer "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variants", force: :cascade do |t|
    t.string "SKU"
    t.integer "product_id"
    t.integer "count_on_hand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", precision: 8, scale: 2
    t.decimal "cost_price", precision: 8, scale: 2
    t.text "description"
    t.boolean "active", default: false
    t.boolean "hidden", default: false
  end

  add_foreign_key "images", "products"
  add_foreign_key "images", "variants"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "line_items", "variants"
  add_foreign_key "messages", "users"
  add_foreign_key "option_value_variants", "option_values"
  add_foreign_key "option_value_variants", "variants"
  add_foreign_key "product_option_types", "option_types"
  add_foreign_key "product_option_types", "products"
  add_foreign_key "properties", "products"
  end
end
