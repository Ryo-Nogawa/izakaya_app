class CreateReserves < ActiveRecord::Migration[6.0]
  def change
    create_table :reserves do |t|
      t.references :user,            null: false
      t.datetime  :datetime,         null: false
      t.integer   :number_reserve,   null: false
      t.integer   :reserve_category, null: false
      t.timestamps
    end
  end
end
