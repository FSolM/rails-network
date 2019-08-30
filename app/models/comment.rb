class Comment < ApplicationRecord
  validates :author, presence: true
  validates :post, presence: :true

  # Relationships with User model
  belongs_to :author, foreign_key: :author_id, class_name: :User

  # Relationships with Post model
  belongs_to :post, foreign_key: :post_id, class_name: :Post
end
