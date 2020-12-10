class Blog < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :blog_comments, dependent: :destroy
  has_many :blog_likes

  with_options presence: true do
    # タイトルは最大100文字
    validates :title,  length: { maximum: 100 }
    # 内容は最大3,000文字
    validates :text,   length: { maximum: 3000 }
    # 画像はなくても保存できる
  end
end
