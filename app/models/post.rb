class Post < ApplicationRecord
  default_scope { order(created_at: :desc) }
  
  validates :author, presence: true
  validates :content, presence: true
  

  # Relationship with User model
  belongs_to :author, foreign_key: :author_id, class_name: :User

  # Relationship with Comment model
  has_many :comments, foreign_key: :id, dependent: :destroy
end
