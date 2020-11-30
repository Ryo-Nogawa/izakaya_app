class CreateReserves < ActiveRecord::Migration[6.0]
  def change
    create_table :reserves do |t|
      t.references :user,            null: false
      t.date       :reserve_date,    null: false
      t.time       :reserve_time,    null: false
      t.integer    :number_reserve,   null: false
      t.integer    :reserve_category, null: false
      t.timestamps
    end
  end
end
