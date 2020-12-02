class ChatUser < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  validates :chat_id, uniquness: {scope: :user_id}
end
