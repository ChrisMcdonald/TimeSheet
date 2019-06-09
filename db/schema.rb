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

ActiveRecord::Schema.define(version: 20181124065802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatroom_users", force: :cascade do |t|
    t.bigint "chatroom_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_read_at"
    t.index ["chatroom_id"], name: "index_chatroom_users_on_chatroom_id"
    t.index ["user_id"], name: "index_chatroom_users_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chatrooms_on_user_id"
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "street_no"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "post_code"
    t.string "abn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "email"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "identities", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "uid"
    t.string "provider"
    t.string "token"
    t.string "secrect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_page"
    t.string "image"
    t.string "username"
    t.string "email"
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.string "name"
    t.date "endOfFortnight"
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.string "owner_first_name"
    t.string "owner_last_name"
    t.string "owner_email"
    t.string "owner_street_no"
    t.string "owner_street"
    t.string "owner_city"
    t.string "owner_country"
    t.string "owner_post_code"
    t.string "owner_abn"
    t.string "customer_first_name"
    t.string "customer_last_name"
    t.string "customer_email"
    t.string "customer_street_no"
    t.string "customer_street"
    t.string "customer_city"
    t.string "customer_country"
    t.string "customer_post_code"
    t.string "customer_abn"
    t.date "invoice_date"
    t.string "customer_state"
    t.string "owner_state"
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
    t.index ["project_id"], name: "index_invoices_on_project_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chatroom_id"
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pay_rates", id: :serial, force: :cascade do |t|
    t.decimal "rate"
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "holiday"
    t.decimal "superannuation"
    t.datetime "date"
    t.index ["project_id"], name: "index_pay_rates_on_project_id"
    t.index ["user_id"], name: "index_pay_rates_on_user_id"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.integer "user_id"
    t.string "gitname"
    t.string "branch"
    t.index ["customer_id"], name: "index_projects_on_customer_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "time_sheets", id: :serial, force: :cascade do |t|
    t.date "time_period"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "hour"
    t.string "description"
    t.datetime "date"
    t.bigint "project_id"
    t.bigint "invoice_id"
    t.index ["invoice_id"], name: "index_time_sheets_on_invoice_id"
    t.index ["project_id"], name: "index_time_sheets_on_project_id"
    t.index ["user_id"], name: "index_time_sheets_on_user_id"
  end

  create_table "travels", force: :cascade do |t|
    t.integer "od_start"
    t.integer "od_finish"
    t.string "purpose"
    t.bigint "user_id"
    t.bigint "project_id"
    t.bigint "time_sheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id"
    t.date "travel_date"
    t.index ["project_id"], name: "index_travels_on_project_id"
    t.index ["time_sheet_id"], name: "index_travels_on_time_sheet_id"
    t.index ["user_id"], name: "index_travels_on_user_id"
    t.index ["vehicle_id"], name: "index_travels_on_vehicle_id"
  end

  create_table "user_pay_obligations", force: :cascade do |t|
    t.decimal "superannuation", precision: 5, scale: 2
    t.decimal "holiday", precision: 5, scale: 2
    t.decimal "hourly_rate", precision: 5, scale: 2
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_pay_obligations_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.string "first_name"
    t.string "last_name"
    t.string "street_no"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "post_code"
    t.string "abn"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "rego_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", id: :serial, force: :cascade do |t|
    t.date "date"
    t.float "hour"
    t.string "description"
    t.integer "project_id"
    t.integer "time_sheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_id"
    t.index ["invoice_id"], name: "index_works_on_invoice_id"
    t.index ["project_id"], name: "index_works_on_project_id"
    t.index ["time_sheet_id"], name: "index_works_on_time_sheet_id"
  end

  add_foreign_key "chatroom_users", "chatrooms"
  add_foreign_key "chatroom_users", "users"
  add_foreign_key "chatrooms", "users"
  add_foreign_key "customers", "users"
  add_foreign_key "invoices", "customers"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "pay_rates", "projects"
  add_foreign_key "pay_rates", "users"
  add_foreign_key "projects", "customers"
  add_foreign_key "projects", "users"
  add_foreign_key "time_sheets", "invoices"
  add_foreign_key "time_sheets", "projects"
  add_foreign_key "time_sheets", "users"
  add_foreign_key "travels", "projects"
  add_foreign_key "travels", "time_sheets"
  add_foreign_key "travels", "users"
  add_foreign_key "travels", "vehicles"
  add_foreign_key "user_pay_obligations", "users"
  add_foreign_key "works", "invoices"
  add_foreign_key "works", "projects"
  add_foreign_key "works", "time_sheets"
end
