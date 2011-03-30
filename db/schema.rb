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

ActiveRecord::Schema.define(:version => 20110330121148) do

  create_table "affairs", :force => true do |t|
    t.string  "role"
    t.integer "member_id"
    t.integer "season_id"
  end

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

  create_table "link_categories", :force => true do |t|
    t.string   "name"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "partitions", :force => true do |t|
    t.string   "name"
    t.integer  "season_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "sections", :force => true do |t|
    t.string  "slug"
    t.integer "parent_id"
    t.string  "name"
    t.text    "contact_info"
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
  end

end
