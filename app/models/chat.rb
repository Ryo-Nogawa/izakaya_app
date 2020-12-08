class Chat < ApplicationRecord
  has_many :chat_users
  has_many :users, through: :chat_users

  # チャットルームの名前は最大40文字
  validates :name, presence: true, length: { minimum: 1, maximum: 40 }
end
