class Food < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :food_category

  belongs_to :user
  has_many :food_comments
  has_one_attached :image
  has_many :food_likes

  with_options presence: true do
    validates :food_category_id, numericality: { other_than: 1 }
  end

end
