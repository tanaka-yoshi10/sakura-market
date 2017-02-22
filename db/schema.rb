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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define do

  create_table "addresses", force: :cascade do |t|
    t.string   "zip_code"
    t.string   "prefectures"
    t.string   "city"
    t.string   "address"
    t.string   "address2"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "price"
    t.integer  "unit_price"
    t.index ["product_id"], name: "index_cart_items_on_product_id", using: :btree
  end

  create_table "cod_charges", force: :cascade do |t|
    t.string   "cod_charge_code"
    t.decimal  "charge",          precision: 10
    t.decimal  "start_amount",    precision: 10
    t.decimal  "end_amount",      precision: 10
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "order_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.decimal  "unit_price",  precision: 10
    t.decimal  "total_price", precision: 10
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_items_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "order_datetime"
    t.integer  "status"
    t.string   "payment_code"
    t.integer  "ship_time_id"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.decimal  "subtotal",        precision: 10
    t.decimal  "total",           precision: 10
    t.decimal  "shipping_charge", precision: 10
    t.decimal  "cod_charge",      precision: 10
    t.string   "payment_type"
    t.date     "ship_date"
    t.string   "ship_address"
    t.string   "ship_zip_code"
    t.index ["ship_time_id"], name: "index_orders_on_ship_time_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",                       precision: 10
    t.text     "description",   limit: 65535
    t.boolean  "display_flag"
    t.integer  "display_order"
    t.string   "image"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "ship_times", force: :cascade do |t|
    t.string   "shiptime_code"
    t.string   "display_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "user_type"
    t.boolean  "admin_flag"
    t.string   "tel"
  end

  add_foreign_key "cart_items", "products"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "ship_times"
  add_foreign_key "orders", "users"
end
