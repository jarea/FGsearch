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

ActiveRecord::Schema.define(:version => 20111004040149) do

  create_table "beautynews", :force => true do |t|
    t.integer  "bk_id"
    t.integer  "num"
    t.string   "topic"
    t.string   "topic_content"
    t.string   "author"
    t.datetime "datetime"
    t.string   "img_url"
    t.integer  "pvcount"
    t.integer  "cat_id"
    t.string   "cat_name"
    t.string   "cse_title"
    t.string   "cse_url"
    t.string   "cse_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beautynews_keywords", :force => true do |t|
    t.integer  "bsk_id"
    t.integer  "beautynews_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beautynews_search_keywords", :force => true do |t|
    t.string   "keyword"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beautynews_search_keywords", ["keyword"], :name => "index_beautynews_search_keywords_on_keyword"

  create_table "blog_keywords", :force => true do |t|
    t.integer  "bsk_id"
    t.integer  "blog_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_search_keywords", :force => true do |t|
    t.string   "keyword"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blog_search_keywords", ["keyword"], :name => "index_blog_search_keywords_on_keyword"

  create_table "blogs", :force => true do |t|
    t.integer  "bk_id"
    t.integer  "num"
    t.string   "topic"
    t.string   "img_url"
    t.datetime "date"
    t.string   "type_name"
    t.integer  "click_amount"
    t.integer  "amount"
    t.string   "per_name"
    t.string   "cse_url"
    t.string   "cse_title"
    t.string   "cse_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fg_beautynews", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fg_beautynews_cates", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fg_keyword_associates", :force => true do |t|
    t.integer  "parent_keyword_id"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fg_keywords", :force => true do |t|
    t.string   "keyword"
    t.integer  "associate_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fg_keywords", ["keyword"], :name => "index_fg_keywords_on_keyword"

  create_table "fg_videos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_keywords", :force => true do |t|
    t.integer  "fsk_id"
    t.integer  "topic_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_search_keywords", :force => true do |t|
    t.string   "keyword"
    t.integer  "total"
    t.integer  "beauty_total"
    t.integer  "fashion_total"
    t.integer  "freetalk_total"
    t.integer  "fit_total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forum_search_keywords", ["keyword"], :name => "index_forum_search_keywords_on_keyword"

  create_table "forums", :force => true do |t|
    t.integer  "fk_id"
    t.integer  "topic_num"
    t.integer  "board_num"
    t.string   "topic"
    t.string   "openuser"
    t.integer  "amount"
    t.datetime "datetime"
    t.string   "cse_url"
    t.string   "cse_title"
    t.string   "cse_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", :force => true do |t|
    t.string   "keyword",                   :null => false
    t.integer  "count",      :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_keywords", :force => true do |t|
    t.integer  "psk_id"
    t.integer  "product_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_search_keywords", :force => true do |t|
    t.string   "keyword"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_search_keywords", ["keyword"], :name => "index_product_search_keywords_on_keyword"

  create_table "products", :force => true do |t|
    t.integer  "pk_id"
    t.integer  "num"
    t.string   "topic"
    t.string   "product_name"
    t.integer  "product_num"
    t.string   "img_url"
    t.datetime "date"
    t.integer  "amount"
    t.string   "price"
    t.string   "volume"
    t.string   "cse_url"
    t.string   "cse_title"
    t.string   "cse_description"
    t.integer  "item_type"
    t.integer  "version"
    t.integer  "item1grade"
    t.integer  "item2grade"
    t.integer  "item3grade"
    t.integer  "item4grade"
    t.integer  "item5grade"
    t.integer  "item6grade"
    t.integer  "item7grade"
    t.integer  "item8grade"
    t.integer  "item9grade"
    t.integer  "item10grade"
    t.integer  "item_total_sum"
    t.integer  "item_grade_1_sum"
    t.integer  "item_grade_2_sum"
    t.integer  "item_grade_3_sum"
    t.integer  "item_grade_4_sum"
    t.integer  "item_grade_5_sum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_keywords", :force => true do |t|
    t.string   "keyword"
    t.integer  "total"
    t.integer  "beauty_total"
    t.integer  "fashion_total"
    t.integer  "freetalk_total"
    t.integer  "fit_total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_keywords", ["keyword"], :name => "index_search_keywords_on_keyword"

  create_table "searches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "video_keywords", :force => true do |t|
    t.integer  "vsk_id"
    t.integer  "video_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "video_search_keywords", :force => true do |t|
    t.string   "keyword"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "video_search_keywords", ["keyword"], :name => "index_video_search_keywords_on_keyword"

  create_table "videos", :force => true do |t|
    t.integer  "vk_id"
    t.integer  "num"
    t.string   "img_url"
    t.string   "topic"
    t.text     "topic_content"
    t.integer  "click_amount"
    t.integer  "amount"
    t.date     "date"
    t.string   "cse_title"
    t.string   "cse_url"
    t.string   "cse_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
