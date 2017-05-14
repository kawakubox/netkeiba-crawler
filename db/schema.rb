ActiveRecord::Schema.define(version: 20170501000000) do

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

end
