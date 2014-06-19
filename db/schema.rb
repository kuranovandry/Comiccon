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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140328032550) do

  create_table "books", force: true do |t|
    t.string   "title"
    t.text     "description",        limit: 255
    t.string   "author_name"
    t.string   "publisher_name"
    t.date     "published_date"
    t.decimal  "unit_price"
    t.integer  "total_rating_value",             default: 0
    t.integer  "total_rating_count",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "books_categories", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "book_id"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "rating",     default: 0
    t.text     "content"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["book_id"], name: "index_comments_on_book_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "order_lines", force: true do |t|
    t.decimal  "unit_price"
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_lines", ["book_id"], name: "index_order_lines_on_book_id"
  add_index "order_lines", ["order_id"], name: "index_order_lines_on_order_id"

  create_table "orders", force: true do |t|
    t.string   "shipping_address"
    t.decimal  "total_amount"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.date     "birthday"
    t.string   "phone"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
