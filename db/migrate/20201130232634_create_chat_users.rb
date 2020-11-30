class CreateChatUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_users do |t|
      t.references :user, foregin_key: true
      t.references :chat, foregin_key: true
      t.timestamps
    end
  end
end
