class DrinkLike < ApplicationRecord
  belongs_to :user
  belongs_to :drink 

  validates_uniquness_of :drink_id, scope: :user_id
end
