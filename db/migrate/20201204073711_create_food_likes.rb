class CreateFoodLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :food_likes do |t|
      t.references :user, foreign_key: true
      t.references :food, foreign_key: true
      t.timestamps
    end
  end
end
