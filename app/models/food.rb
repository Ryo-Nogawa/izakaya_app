class Food < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :food_category

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :food_category_id, numericality: { other_than: 1 }
  end

end
