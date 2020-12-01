class Drink < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :drink_category

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :drink_category_id, numericality: { other_than: 1 }
  end
end
