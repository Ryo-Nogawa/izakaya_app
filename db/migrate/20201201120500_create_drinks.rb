class CreateDrinks < ActiveRecord::Migration[6.0]
  def change
    create_table :drinks do |t|
      t.references :user,              foreign_key: true
      t.string     :title,             null: false
      t.string     :detail,            null: false
      t.integer    :price,             null: false
      t.integer    :drink_category_id, null: false
      t.boolean    :free_drink,        default: false, null: false
      t.timestamps
    end
  end
end
