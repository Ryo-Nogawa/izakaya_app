# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_112_204_632) do
  create_table 'active_storage_attachments', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'blog_comments', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'blog_id'
    t.text 'comment', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['blog_id'], name: 'index_blog_comments_on_blog_id'
    t.index ['user_id'], name: 'index_blog_comments_on_user_id'
  end

  create_table 'blog_likes', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'blog_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['blog_id'], name: 'index_blog_likes_on_blog_id'
    t.index ['user_id'], name: 'index_blog_likes_on_user_id'
  end

  create_table 'blogs', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'title', null: false
    t.text 'text', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_blogs_on_user_id'
  end

  create_table 'books', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.date 'reserve_date', null: false
    t.time 'reserve_time', null: false
    t.integer 'number_reserve', null: false
    t.integer 'reserve_category_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_books_on_user_id'
  end

  create_table 'drink_comments', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'drink_id'
    t.string 'comment', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['drink_id'], name: 'index_drink_comments_on_drink_id'
    t.index ['user_id'], name: 'index_drink_comments_on_user_id'
  end

  create_table 'drink_likes', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'drink_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['drink_id'], name: 'index_drink_likes_on_drink_id'
    t.index ['user_id'], name: 'index_drink_likes_on_user_id'
  end

  create_table 'drinks', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'title', null: false
    t.string 'detail', null: false
    t.integer 'price', null: false
    t.integer 'drink_category_id', null: false
    t.boolean 'free_drink', default: false, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_drinks_on_user_id'
  end

  create_table 'food_comments', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'food_id'
    t.string 'comment', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['food_id'], name: 'index_food_comments_on_food_id'
    t.index ['user_id'], name: 'index_food_comments_on_user_id'
  end

  create_table 'food_likes', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'food_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['food_id'], name: 'index_food_likes_on_food_id'
    t.index ['user_id'], name: 'index_food_likes_on_user_id'
  end

  create_table 'foods', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'title', null: false
    t.string 'detail', null: false
    t.integer 'price', null: false
    t.integer 'food_category_id', null: false
    t.boolean 'free_food', default: false, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_foods_on_user_id'
  end

  create_table 'messages', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'content', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_messages_on_user_id'
  end

  create_table 'room_users', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'room_id'
    t.bigint 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['room_id'], name: 'index_room_users_on_room_id'
    t.index ['user_id'], name: 'index_room_users_on_user_id'
  end

  create_table 'rooms', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'sns_credentials', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'provider'
    t.string 'uid'
    t.bigint 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_sns_credentials_on_user_id'
  end

  create_table 'users', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'nickname', null: false
    t.string 'name', null: false
    t.string 'name_kana', null: false
    t.integer 'age', null: false
    t.string 'phone_number', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.boolean 'admin', default: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'visuals', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.integer 'visual_category_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_visuals_on_user_id'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'blog_comments', 'blogs'
  add_foreign_key 'blog_comments', 'users'
  add_foreign_key 'blog_likes', 'blogs'
  add_foreign_key 'blog_likes', 'users'
  add_foreign_key 'blogs', 'users'
  add_foreign_key 'books', 'users'
  add_foreign_key 'drink_comments', 'drinks'
  add_foreign_key 'drink_comments', 'users'
  add_foreign_key 'drink_likes', 'drinks'
  add_foreign_key 'drink_likes', 'users'
  add_foreign_key 'drinks', 'users'
  add_foreign_key 'food_comments', 'foods'
  add_foreign_key 'food_comments', 'users'
  add_foreign_key 'food_likes', 'foods'
  add_foreign_key 'food_likes', 'users'
  add_foreign_key 'foods', 'users'
  add_foreign_key 'room_users', 'rooms'
  add_foreign_key 'room_users', 'users'
  add_foreign_key 'sns_credentials', 'users'
  add_foreign_key 'visuals', 'users'
end
