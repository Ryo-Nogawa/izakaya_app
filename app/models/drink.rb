class Drink < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :drink_category

  belongs_to :user
  has_one_attached :image
  has_many :drink_comments

  with_options presence: true do
    # カテゴリー選択は1以外
    validates :drink_category_id, numericality: { other_than: 1 }
    # 商品名は40文字以内
    validates :title, length: { minimum: 1, maximum: 40 }
    # 商品詳細は250文字以内
    validates :detail, length: { minimum: 1, maximum: 250 }
    # 値段は半角数字
    validates :price, numericality: { only_integer: true, greater_than: 1, less_than: 9_999_999}, format: { with: /\A[0-9]+\z/ }
    # 画像は必須
    validates :image
  end
end
