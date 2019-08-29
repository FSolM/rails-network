class Post < ApplicationRecord
  default_scope { order(created_at: :desc) }
  
  validates :author, presence: true
  validates :content, presence: true
  

  # Relationship with User
  belongs_to :author, foreign_key: :author_id, class_name: :User
end
