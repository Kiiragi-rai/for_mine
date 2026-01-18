# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_01_18_144743) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anniversaries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.date "anniversary_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notification_on", default: false, null: false
    t.index ["user_id"], name: "index_anniversaries_on_user_id"
  end

  create_table "gift_suggestions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "input_json"
    t.jsonb "result_json"
    t.string "status"
    t.text "error_message"
    t.index ["user_id"], name: "index_gift_suggestions_on_user_id"
  end

  create_table "partners", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "sex"
    t.string "relation"
    t.string "job"
    t.text "favorites", default: [], array: true
    t.text "avoidances", default: [], array: true
    t.text "hobbies", default: [], array: true
    t.integer "budget_min"
    t.integer "budget_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.index ["user_id"], name: "index_partners_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", default: "", null: false
    t.string "uid", default: "", null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "anniversaries", "users"
  add_foreign_key "gift_suggestions", "users"
  add_foreign_key "partners", "users"
end
