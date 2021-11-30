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

ActiveRecord::Schema.define(version: 2021_11_29_171502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name", limit: 255, null: false
    t.index ["country_id", "name"], name: "index_cities_on_country_id_and_name", unique: true
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.bigint "user_id", null: false
    t.string "phone_number", limit: 20
    t.date "birth_date"
    t.text "about_me"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "username", limit: 255, null: false
    t.string "pin", limit: 11, null: false
    t.bigint "country_id", null: false
    t.bigint "city_id", null: false
    t.boolean "terms_of_use", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["pin"], name: "index_users_on_pin", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "cities", "countries"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "cities"
  add_foreign_key "users", "countries"
end
