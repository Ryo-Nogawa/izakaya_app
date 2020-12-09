class CreateBlogLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_likes do |t|
      t.references :user, foreign_key: true
      t.references :blog, foreign_key: true
      t.timestamps
    end
  end
end
