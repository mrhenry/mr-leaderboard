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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110201211952) do

  create_table "leaderboards", :force => true do |t|
    t.string    "title"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.integer   "leaderboard_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer   "leaderboard_id"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "won_games",      :default => 0
    t.integer   "played_games",   :default => 0
    t.integer   "won_matches",    :default => 0
    t.integer   "played_matches", :default => 0
  end

  create_table "scores", :force => true do |t|
    t.integer   "user_id"
    t.integer   "score"
    t.integer   "match_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "login"
    t.string    "email"
    t.string    "level"
    t.string    "crypted_password"
    t.string    "password_salt"
    t.string    "persistence_token"
    t.string    "single_access_token"
    t.string    "perishable_token"
    t.integer   "login_count"
    t.integer   "failed_login_count"
    t.timestamp "last_request_at"
    t.timestamp "current_login_at"
    t.timestamp "last_login_at"
    t.string    "current_login_ip"
    t.string    "last_login_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "active",              :default => false, :null => false
    t.string    "display_name"
  end

end
