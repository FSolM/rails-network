class Comment < ApplicationRecord
  attr_readonly :user_id, :post_id

  belongs_to :author, foreign_key: :author_id, class_name: :User
  belongs_to :post
end
