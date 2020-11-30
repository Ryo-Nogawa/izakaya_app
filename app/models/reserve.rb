class Reserve < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :reserve_category

  with_options presence: true do
    validates :reserve_category_id, numericality: { other_than: 1 }
  end
end
