# frozen_string_literal: true

class BlogComment < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  # 250文字以内
  validates :comment, presence: true, length: { minimum: 1, maximum: 250 }
end
