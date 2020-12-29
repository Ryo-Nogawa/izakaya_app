class CreateVisuals < ActiveRecord::Migration[6.0]
  def change
    create_table :visuals do |t|
      t.references :user,               foreign_key: true
      t.integer    :visual_category_id, null: false

      t.timestamps
    end
  end
end
