ActiveRecord::Schema.define(version: 20170625012735) do

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

  create_table "horse_results", force: :cascade do |t|
    t.integer  "horse_id",                                 null: false
    t.integer  "race_id",                                  null: false
    t.integer  "jockey_id"
    t.integer  "trainer_id"
    t.integer  "order"
    t.decimal  "race_time",        precision: 4, scale: 1
    t.decimal  "jockey_weight",    precision: 3, scale: 1
    t.integer  "horse_weight"
    t.integer  "weight_diff"
    t.integer  "gate_number"
    t.integer  "horse_number"
    t.integer  "popularity"
    t.integer  "course_condition"
    t.decimal  "last_3f",          precision: 3, scale: 1
    t.string   "corner_position"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["horse_id", "race_id"], name: "index_horse_results_on_horse_id_and_race_id", unique: true, using: :btree
    t.index ["jockey_id"], name: "index_horse_results_on_jockey_id", using: :btree
    t.index ["race_id"], name: "index_horse_results_on_race_id", using: :btree
    t.index ["trainer_id"], name: "index_horse_results_on_trainer_id", using: :btree
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
    t.integer  "event_id",         null: false
    t.integer  "kind"
    t.integer  "course_type"
    t.integer  "direction"
    t.integer  "circumference"
    t.index ["event_id"], name: "index_races_on_event_id", using: :btree
    t.index ["key"], name: "index_races_on_key", unique: true, using: :btree
  end

  create_table "trainers", force: :cascade do |t|
    t.string   "key",        null: false
    t.string   "name"
    t.integer  "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_trainers_on_key", unique: true, using: :btree
  end
end
