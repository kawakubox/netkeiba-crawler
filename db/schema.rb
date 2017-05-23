ActiveRecord::Schema.define(version: 20170505000000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "key"
    t.date     "held_on"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_events_on_key", unique: true, using: :btree
  end

  create_table "horses", force: :cascade do |t|
    t.string   "key",        null: false
    t.string   "name"
    t.date     "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_horses_on_key", unique: true, using: :btree
  end

  create_table "jockeys", force: :cascade do |t|
    t.string   "key",        null: false
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_jockeys_on_key", unique: true, using: :btree
  end

  create_table "races", force: :cascade do |t|
    t.string   "key",              null: false
    t.integer  "ordinal"
    t.string   "name"
    t.integer  "grade"
    t.integer  "distance"
    t.integer  "weather"
    t.integer  "course_condition"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["key"], name: "index_races_on_key", unique: true, using: :btree
  end
end
