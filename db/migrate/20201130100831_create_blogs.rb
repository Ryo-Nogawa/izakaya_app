class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.references :user,  foregin_key: true
      t.string     :title, null: false
      t.text       :text,  null: false
      t.timestamps
    end
  end
end
