class CreateDrinkLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :drink_likes do |t|
      t.references :user,  foreign_key: true
      t.references :drink, foreign_key: true
      t.timestamps
    end
  end
end
