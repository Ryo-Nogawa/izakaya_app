class CreateDrinkComments < ActiveRecord::Migration[6.0]
  def change
    create_table :drink_comments do |t|
      t.references :user,    foreign_key: true
      t.references :drink,   foreign_key: true
      t.string     :comment, null: false
      t.timestamps
    end
  end
end
