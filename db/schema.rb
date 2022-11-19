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

ActiveRecord::Schema[7.0].define(version: 2022_11_01_010127) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "effort_stats", force: :cascade do |t|
    t.integer "hp"
    t.integer "attack"
    t.integer "defense"
    t.integer "special_attack"
    t.integer "special_defense"
    t.integer "speed"
    t.bigint "my_pokemon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["my_pokemon_id"], name: "index_effort_stats_on_my_pokemon_id"
  end

  create_table "indiv_stats", force: :cascade do |t|
    t.integer "hp"
    t.integer "attack"
    t.integer "defense"
    t.integer "special_attack"
    t.integer "special_defense"
    t.integer "speed"
    t.bigint "my_pokemon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["my_pokemon_id"], name: "index_indiv_stats_on_my_pokemon_id"
  end

  create_table "my_pokemons", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pokemon_id", null: false
    t.string "nickname"
    t.integer "experience", default: 0
    t.integer "level", default: 1
    t.integer "actual_hp", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokemon_id"], name: "index_my_pokemons_on_pokemon_id"
    t.index ["user_id"], name: "index_my_pokemons_on_user_id"
  end

  create_table "pokemon_stats", force: :cascade do |t|
    t.bigint "stat_id", null: false
    t.bigint "pokemon_id", null: false
    t.integer "base_stat"
    t.integer "effort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokemon_id"], name: "index_pokemon_stats_on_pokemon_id"
    t.index ["stat_id"], name: "index_pokemon_stats_on_stat_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name"
    t.integer "weight"
    t.integer "height"
    t.string "image"
    t.integer "base_experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons_types", id: false, force: :cascade do |t|
    t.bigint "pokemon_id", null: false
    t.bigint "type_id", null: false
  end

  create_table "real_stats", force: :cascade do |t|
    t.integer "hp"
    t.integer "attack"
    t.integer "defense"
    t.integer "special_attack"
    t.integer "special_defense"
    t.integer "speed"
    t.bigint "my_pokemon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["my_pokemon_id"], name: "index_real_stats_on_my_pokemon_id"
  end

  create_table "stats", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "effort_stats", "my_pokemons"
  add_foreign_key "indiv_stats", "my_pokemons"
  add_foreign_key "my_pokemons", "pokemons"
  add_foreign_key "my_pokemons", "users"
  add_foreign_key "pokemon_stats", "pokemons"
  add_foreign_key "pokemon_stats", "stats"
  add_foreign_key "real_stats", "my_pokemons"
end
