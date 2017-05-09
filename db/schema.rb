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

ActiveRecord::Schema.define(version: 20170509154227) do

  create_table "idps", force: :cascade do |t|
    t.string "simple_id"
    t.boolean "enabled"
    t.string "entity_id"
    t.string "signing_cert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "r_transactions", force: :cascade do |t|
    t.string "simple_id"
    t.boolean "eidas_enabled"
    t.string "entity_id"
    t.string "signing_cert"
    t.string "levels_of_assurance"
    t.string "assertion_consumer_service_uri"
    t.string "service_homepage"
    t.string "matching_service_entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "simple_id"
    t.boolean "eidas_enabled"
    t.string "entity_id"
    t.string "signing_cert"
    t.string "levels_of_assurance"
    t.string "assertion_consumer_service_uri"
    t.string "service_homepage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
