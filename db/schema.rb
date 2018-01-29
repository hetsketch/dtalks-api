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

ActiveRecord::Schema.define(version: 20180129073340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "text"
    t.integer "user_id"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.string "city", null: false
    t.text "info", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employees_count", default: 0
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "employees", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "company_id"
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "text"
    t.datetime "event_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "photo"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.index ["user_id", "event_id"], name: "index_events_users_on_user_id_and_event_id"
  end

  create_table "impressions", id: :serial, force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "topics", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.string "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "impressions_count", default: 0
    t.integer "comments_count", default: 0
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "position"
    t.string "city"
    t.string "bio"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
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
    t.string "avatar"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "users", "companies"
end
