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

ActiveRecord::Schema.define(version: 20150707225614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_services", force: :cascade do |t|
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
  end

  add_index "customer_services", ["email"], name: "index_customer_services_on_email", unique: true, using: :btree
  add_index "customer_services", ["reset_password_token"], name: "index_customer_services_on_reset_password_token", unique: true, using: :btree

  create_table "event_managers", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "approved",               default: false, null: false
    t.string   "contact_number",         default: "f",   null: false
  end

  add_index "event_managers", ["approved"], name: "index_event_managers_on_approved", using: :btree
  add_index "event_managers", ["email"], name: "index_event_managers_on_email", unique: true, using: :btree
  add_index "event_managers", ["reset_password_token"], name: "index_event_managers_on_reset_password_token", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "location"
    t.string   "genre"
    t.string   "dress_code"
    t.date     "date_from"
    t.date     "date_to"
    t.time     "time_to"
    t.time     "time_from"
    t.string   "contact_number"
    t.string   "ticket_type"
    t.float    "price"
    t.integer  "tickets_allocated"
    t.boolean  "approved",          default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "event_manager_id"
  end

  add_index "events", ["event_manager_id"], name: "index_events_on_event_manager_id", using: :btree
  add_index "events", ["title"], name: "index_events_on_title", using: :btree

end
