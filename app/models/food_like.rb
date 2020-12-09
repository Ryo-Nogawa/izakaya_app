class FoodLike < ApplicationRecord
  belongs_to :user
  belongs_to :food

  validates_uniquness_of :food_id, scope: :user_id
end
