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

ActiveRecord::Schema.define(:version => 20110819145529) do

  create_table "answers", :force => true do |t|
    t.integer  "question_option_id"
    t.integer  "user_id"
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_option_id"], :name => "index_answers_on_question_option_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "question_options", :force => true do |t|
    t.integer  "question_id"
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_options", ["question_id"], :name => "index_question_options_on_question_id"

  create_table "questions", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "number"
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["survey_id"], :name => "index_questions_on_survey_id"

  create_table "surveys", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.boolean  "is_private", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "surveys", ["user_id"], :name => "index_surveys_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end
