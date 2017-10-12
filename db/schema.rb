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

ActiveRecord::Schema.define(version: 20171012042328) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_no"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "post_code"
    t.string   "abn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.string   "user_id"
    t.string   "uid"
    t.string   "provider"
    t.string   "token"
    t.string   "secrect"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "profile_page"
    t.string   "image"
  end

  create_table "invoice_rows", force: :cascade do |t|
    t.float    "rate"
    t.float    "hours"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "invoice_id"
    t.string   "username"
    t.date     "date"
    t.index ["invoice_id"], name: "index_invoice_rows_on_invoice_id", using: :btree
    t.index ["project_id"], name: "index_invoice_rows_on_project_id", using: :btree
  end

  create_table "invoices", force: :cascade do |t|
    t.string   "name"
    t.date     "endOfFortnight"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "customer_id"
    t.string   "owner_first_name"
    t.string   "owner_last_name"
    t.string   "owner_email"
    t.string   "owner_street_no"
    t.string   "owner_street"
    t.string   "owner_city"
    t.string   "owner_country"
    t.string   "owner_post_code"
    t.string   "owner_abn"
    t.string   "customer_first_name"
    t.string   "customer_last_name"
    t.string   "customer_email"
    t.string   "customer_street_no"
    t.string   "customer_street"
    t.string   "customer_city"
    t.string   "customer_country"
    t.string   "customer_post_code"
    t.string   "customer_abn"
    t.date     "invoice_date"
    t.string   "customer_state"
    t.string   "owner_state"
    t.index ["customer_id"], name: "index_invoices_on_customer_id", using: :btree
    t.index ["project_id"], name: "index_invoices_on_project_id", using: :btree
    t.index ["user_id"], name: "index_invoices_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.float    "hours"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
    t.integer  "user_id"
    t.index ["customer_id"], name: "index_projects_on_customer_id", using: :btree
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "time_sheets", force: :cascade do |t|
    t.date     "time_period"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_time_sheets_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_no"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "post_code"
    t.string   "abn"
    t.string   "rate"
  end

  create_table "works", force: :cascade do |t|
    t.date     "date"
    t.integer  "hour"
    t.string   "description"
    t.integer  "project_id"
    t.integer  "time_sheet_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["project_id"], name: "index_works_on_project_id", using: :btree
    t.index ["time_sheet_id"], name: "index_works_on_time_sheet_id", using: :btree
  end

  add_foreign_key "invoice_rows", "invoices"
  add_foreign_key "invoices", "customers"
  add_foreign_key "projects", "customers"
  add_foreign_key "projects", "users"
  add_foreign_key "time_sheets", "users"
  add_foreign_key "works", "projects"
  add_foreign_key "works", "time_sheets"
end
