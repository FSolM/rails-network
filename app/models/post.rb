class Post < ApplicationRecord
  validates :author, presence: true
  validates :content, presence: true
  

  # Relationship with User
  belongs_to :author, foreign_key: :author_id, class_name: :User
end
