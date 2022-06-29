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

ActiveRecord::Schema[7.0].define(version: 2022_06_29_143248) do
  create_table "affiliations", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "id"
    t.string "title"
    t.string "city"
    t.bigint "country_id", null: false
    t.integer "document_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_affiliations_on_country_id"
    t.index ["id"], name: "index_affiliations_on_id"
  end

  create_table "author_and_paper_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "paper_id", null: false
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_author_and_paper_records_on_author_id"
    t.index ["paper_id"], name: "index_author_and_paper_records_on_paper_id"
  end

  create_table "authors", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "id"
    t.string "first_name"
    t.string "last_name"
    t.bigint "affiliation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliation_id"], name: "index_authors_on_affiliation_id"
    t.index ["id"], name: "index_authors_on_id"
  end

  create_table "countries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "industries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_institutions_on_country_id"
  end

  create_table "ntust_departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "college_id"
    t.string "role", default: "department"
    t.index ["college_id"], name: "index_ntust_departments_on_college_id"
  end

  create_table "papers", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_papers_on_id"
  end

  create_table "recommenders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.string "job_title"
    t.string "department"
    t.bigint "institution_id"
    t.bigint "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "provider_name"
    t.string "provider_email"
    t.index ["industry_id"], name: "index_recommenders_on_industry_id"
    t.index ["institution_id"], name: "index_recommenders_on_institution_id"
  end

  create_table "user_and_recommender_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recommender_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recommender_id"], name: "index_user_and_recommender_records_on_recommender_id"
    t.index ["user_id"], name: "index_user_and_recommender_records_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.bigint "ntust_department_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["ntust_department_id"], name: "index_users_on_ntust_department_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "affiliations", "countries"
  add_foreign_key "author_and_paper_records", "authors"
  add_foreign_key "author_and_paper_records", "papers"
  add_foreign_key "authors", "affiliations"
  add_foreign_key "institutions", "countries"
  add_foreign_key "recommenders", "industries"
  add_foreign_key "recommenders", "institutions"
  add_foreign_key "user_and_recommender_records", "recommenders"
  add_foreign_key "user_and_recommender_records", "users"
  add_foreign_key "users", "ntust_departments"
end
