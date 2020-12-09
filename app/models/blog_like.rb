class BlogLike < ApplicationRecord
  belongs_to :user
  belongs_to :blog 

  validates_uniquness_of :blog_id, scope: :user_id
end
