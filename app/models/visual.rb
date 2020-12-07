class Visual < ApplicationRecord
  belongs_to :user
  has_one_attached :image

    # 画像は必須
    validates :image, presence: true
end
