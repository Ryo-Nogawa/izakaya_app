class Message < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # 250文字以内
  validates :content, presence: true, length: { minimum: 1, maximum: 250}
end
