class Visual < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :visual_category

  belongs_to :user
  has_one_attached :image

  # 画像は必須
  validates :image, presence: true
  validates :visual_category_id
end
