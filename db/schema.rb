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

ActiveRecord::Schema.define(version: 20171014110112) do

  create_table "directs", force: :cascade do |t|
    t.string "user1_id", null: false
    t.string "user2_id", null: false
    t.string "conversation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_profiles", force: :cascade do |t|
    t.string "group_id", null: false
    t.string "group_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "group_id", null: false
    t.string "user_id", null: false
    t.string "conversation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "user_id", null: false
    t.float "lat", null: false
    t.float "lng", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "conversation_id", null: false
    t.string "sender_id", null: false
    t.text "message_body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_contacts", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", id: false, force: :cascade do |t|
    t.string "user_id", null: false
    t.string "nick_name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usergroups", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "user_id", null: false
    t.string "email", null: false
    t.string "password_salted", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waypoints", force: :cascade do |t|
    t.string "active", null: false
    t.string "group_id", null: false
    t.string "creator_id", null: false
    t.float "lat", null: false
    t.float "lng", null: false
    t.string "place_name", null: false
    t.string "place_address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
