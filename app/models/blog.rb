class Blog < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :blog_comments

  with_options presence: true do
    validates :title,  length: { maximum: 100 }
    validates :text,   length: { maximum: 3000 }
  end
end
