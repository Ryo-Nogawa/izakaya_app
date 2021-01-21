# frozen_string_literal: true

class Visual < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :visual_category

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :visual_category_id, numericality: { other_than: 1 }
    validates :image
  end
end
