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

ActiveRecord::Schema.define(version: 20170505113213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"


  create_table "horse_results", force: :cascade do |t|
    t.integer  "race_id"
    t.integer  "horse_id"
    t.integer  "jockey_id"
    t.integer  "trainer"
    t.integer  "order"
    t.decimal  "race_time",        precision: 4, scale: 1
    t.decimal  "jockey_weight",    precision: 3, scale: 1
    t.integer  "horse_weight"
    t.integer  "weight_diff"
    t.integer  "gate_number"
    t.integer  "horse_number"
    t.integer  "popularity"
    t.integer  "course_condition"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "horses", force: :cascade do |t|
    t.string   "key"
    t.string   "name"
    t.date     "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_horses_on_key", using: :btree
  end

  create_table "jockeys", force: :cascade do |t|
    t.string   "key"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "races", force: :cascade do |t|
    t.string   "key"
    t.integer  "ordinal"
    t.string   "name"
    t.integer  "grade"
    t.integer  "distance"
    t.integer  "weather"
    t.integer  "course_condition"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["key"], name: "index_races_on_key", using: :btree
  end

  create_table "trainers", force: :cascade do |t|
    t.string   "key"
    t.string   "name"
    t.integer  "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
