class CreateVisuals < ActiveRecord::Migration[6.0]
  def change
    create_table :visuals do |t|
      t.references :user, foregin_key: true

      t.timestamps
    end
  end
end
