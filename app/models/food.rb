class Food < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :food_category

  belongs_to :user
  has_one_attached :image

end
