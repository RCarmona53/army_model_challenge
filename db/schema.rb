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

ActiveRecord::Schema[7.1].define(version: 2025_10_13_202413) do
  create_table "armies", force: :cascade do |t|
    t.string "civilization", null: false
    t.integer "gold", default: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "battles", force: :cascade do |t|
    t.integer "attacker_id", null: false
    t.integer "defender_id", null: false
    t.string "result"
    t.integer "attacker_points"
    t.integer "defender_points"
    t.datetime "occurred_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attacker_id"], name: "index_battles_on_attacker_id"
    t.index ["defender_id"], name: "index_battles_on_defender_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "type", null: false
    t.integer "extra_points", default: 0, null: false
    t.integer "army_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["army_id"], name: "index_units_on_army_id"
  end

  add_foreign_key "battles", "attackers"
  add_foreign_key "battles", "defenders"
  add_foreign_key "units", "armies"
end
