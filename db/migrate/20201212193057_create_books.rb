class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.references :user,                foreign_key: true
      t.date       :reserve_date,        null: false
      t.time       :reserve_time,        null: false
      t.integer    :number_reserve,      null: false
      t.integer    :reserve_category_id, null: false
      t.timestamps
    end
  end
end
