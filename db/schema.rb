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

ActiveRecord::Schema.define(version: 2012_07_14_222426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animated_gifs", force: :cascade do |t|
    t.string "image"
    t.text "shas"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "git_commits", force: :cascade do |t|
    t.string "image"
    t.string "sha"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "repo_id"
    t.string "raw"
    t.index ["email"], name: "index_git_commits_on_email"
    t.index ["repo_id"], name: "index_git_commits_on_repo_id"
    t.index ["sha"], name: "index_git_commits_on_sha"
    t.index ["user_id"], name: "index_git_commits_on_user_id"
  end

  create_table "repos", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "external_id"
    t.index ["external_id"], name: "index_repos_on_external_id"
    t.index ["username", "name"], name: "index_repos_on_username_and_name"
  end

  create_table "repos_users", id: false, force: :cascade do |t|
    t.integer "repo_id"
    t.integer "user_id"
    t.index ["repo_id", "user_id"], name: "index_repos_users_on_repo_id_and_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "github_id"
    t.string "email"
    t.string "token"
    t.string "api_key"
    t.string "api_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["api_key"], name: "index_users_on_api_key"
    t.index ["github_id"], name: "index_users_on_github_id"
  end

end
