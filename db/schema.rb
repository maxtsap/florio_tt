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

ActiveRecord::Schema[8.0].define(version: 2025_07_22_143143) do
  create_table "drugs", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_drugs_on_name", unique: true
  end

  create_table "injections", force: :cascade do |t|
    t.integer "dose", null: false
    t.string "lot_number", limit: 6, null: false
    t.integer "patient_id", null: false
    t.integer "drug_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drug_id"], name: "index_injections_on_drug_id"
    t.index ["patient_id"], name: "index_injections_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", null: false
    t.string "api_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_patients_on_api_key", unique: true
  end

  add_foreign_key "injections", "drugs"
  add_foreign_key "injections", "patients"
end
