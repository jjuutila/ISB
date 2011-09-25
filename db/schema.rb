# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20110729173805) do

  create_table "affairs", :force => true do |t|
    t.string  "role"
    t.integer "member_id"
    t.integer "season_id"
  end

  add_index "affairs", ["season_id", "role"], :name => "index_affairs_on_season_id_and_role"

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "author"
    t.string   "email"
    t.string   "ip_addr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "link_categories", :force => true do |t|
    t.string   "name"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "link_categories", ["section_id"], :name => "index_link_categories_on_section_id"

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["category_id"], :name => "index_links_on_category_id"

  create_table "matches", :force => true do |t|
    t.integer  "home_team_id"
    t.integer  "visitor_team_id"
    t.integer  "partition_id"
    t.integer  "home_goals"
    t.integer  "visitor_goals"
    t.string   "additional_info"
    t.string   "location"
    t.datetime "start_time"
    t.text     "report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["partition_id"], :name => "index_matches_on_partition_id"

  create_table "members", :force => true do |t|
    t.integer  "number"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "gender"
    t.integer  "position"
    t.integer  "birth_year"
    t.string   "home_municipality"
    t.integer  "all_time_assists"
    t.integer  "all_time_goals"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "shoots",             :limit => 5, :default => "null"
  end

  create_table "news", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_sections", :id => false, :force => true do |t|
    t.integer "news_id"
    t.integer "section_id"
  end

  add_index "news_sections", ["section_id", "news_id"], :name => "index_news_sections_on_section_id_and_news_id"

  create_table "partitions", :force => true do |t|
    t.string   "name"
    t.integer  "season_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partitions", ["season_id"], :name => "index_partitions_on_season_id"

  create_table "questions", :force => true do |t|
    t.string   "content"
    t.string   "answer"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["member_id"], :name => "index_questions_on_member_id"

  create_table "seasons", :force => true do |t|
    t.string   "division"
    t.text     "history"
    t.string   "state"
    t.integer  "section_id"
    t.integer  "start_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["section_id"], :name => "index_seasons_on_section_id"

  create_table "section_groups", :force => true do |t|
    t.string   "name"
    t.boolean  "are_players_male"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string  "slug"
    t.integer "section_group_id"
    t.string  "name"
    t.text    "contact_info"
    t.string  "picasa_user_id"
    t.boolean "is_visible",       :default => false
  end

  add_index "sections", ["section_group_id"], :name => "index_sections_on_section_group_id"

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "position"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "logo_width",        :limit => 2
    t.integer  "logo_height"
  end

  create_table "statistics", :force => true do |t|
    t.integer  "partition_id"
    t.integer  "member_id"
    t.integer  "assists"
    t.integer  "goals"
    t.integer  "matches"
    t.integer  "pim"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statistics", ["partition_id"], :name => "index_statistics_on_partition_id"

  create_table "team_standings", :force => true do |t|
    t.string   "name"
    t.integer  "partition_id"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "overtimes"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank"
  end

  add_index "team_standings", ["partition_id"], :name => "index_team_standings_on_partition_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
