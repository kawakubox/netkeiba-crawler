ActiveRecord::Schema.define(version: 20170903094046) do

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
    t.string   "horse_id",                                 null: false
    t.integer  "order"
    t.string   "race_id",                                  null: false
    t.string   "jockey_id"
    t.string   "trainer_id"
    t.decimal  "race_time",        precision: 4, scale: 1
    t.decimal  "jockey_weight",    precision: 3, scale: 1
    t.integer  "horse_weight"
    t.integer  "weight_diff"
    t.integer  "gate_number"
    t.integer  "horse_number"
    t.integer  "popularity"
    t.integer  "course_condition"
    t.decimal  "last_3f",          precision: 4, scale: 1
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
    t.integer  "sex"
    t.string   "body_color"
    t.integer  "sire_id"
    t.integer  "mare_id"
    t.integer  "trainer_id"
    t.string   "owner"
    t.string   "breeder"
    t.string   "birthplace"
    t.index ["key"], name: "index_horses_on_key", unique: true, using: :btree
    t.index ["mare_id"], name: "index_horses_on_mare_id", using: :btree
    t.index ["sire_id"], name: "index_horses_on_sire_id", using: :btree
    t.index ["trainer_id"], name: "index_horses_on_trainer_id", using: :btree
  end

  create_table "jockeys", force: :cascade do |t|
    t.string   "key",        null: false
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_jockeys_on_key", unique: true, using: :btree
  end

  create_table "payouts", force: :cascade do |t|
    t.integer  "race_id",    null: false
    t.integer  "bet_type",   null: false
    t.integer  "number_1"
    t.integer  "number_2"
    t.integer  "number_3"
    t.integer  "payout",     null: false
    t.integer  "popularity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_payouts_on_race_id", using: :btree
  end

  create_table "race_names", force: :cascade do |t|
    t.string   "long_name",  null: false
    t.string   "short_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["long_name"], name: "index_race_names_on_long_name", unique: true, using: :btree
    t.index ["short_name"], name: "index_race_names_on_short_name", unique: true, using: :btree
  end

  create_table "races", force: :cascade do |t|
    t.integer  "ordinal"
    t.string   "name"
    t.integer  "grade"
    t.integer  "distance"
    t.integer  "weather"
    t.integer  "course_condition"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "event_id",                     null: false
    t.integer  "kind"
    t.integer  "course_type"
    t.integer  "direction"
    t.integer  "circumference"
    t.integer  "race_name_id"
    t.integer  "horses_count",     default: 0, null: false
    t.index ["event_id"], name: "index_races_on_event_id", using: :btree
    t.index ["race_name_id"], name: "index_races_on_race_name_id", using: :btree
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
