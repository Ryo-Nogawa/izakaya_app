class Chat < ApplicationRecord
  has_many :chat_users
  has_many :users, through: :chat_users

  validates :name, presence: true
end
