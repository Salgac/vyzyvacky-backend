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

ActiveRecord::Schema.define(version: 2021_08_24_123511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.datetime "time"
    t.bigint "winner_id", null: false
    t.bigint "looser_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id", null: false
    t.index ["game_id"], name: "index_entries_on_game_id"
    t.index ["looser_id"], name: "index_entries_on_looser_id"
    t.index ["winner_id"], name: "index_entries_on_winner_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "code", null: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.integer "score"
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "age"
    t.bigint "game_id", null: false
    t.index ["game_id"], name: "index_people_on_game_id"
    t.index ["team_id"], name: "index_people_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "score"
    t.bigint "game_id", null: false
    t.index ["game_id"], name: "index_teams_on_game_id"
  end

  add_foreign_key "entries", "games"
  add_foreign_key "entries", "people", column: "looser_id"
  add_foreign_key "entries", "people", column: "winner_id"
  add_foreign_key "people", "games"
  add_foreign_key "people", "teams"
  add_foreign_key "teams", "games"
end
