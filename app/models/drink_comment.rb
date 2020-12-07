class DrinkComment < ApplicationRecord
  belongs_to :user
  belongs_to :drink

  # コメントの最大文字数は250文字
  validates :comment, presence: true, length: { minimum: 1, maximum: 250 }
end
