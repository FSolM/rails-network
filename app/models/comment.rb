# frozen_string_literal: true

# Comment Record; relationships & validations
class Comment < ApplicationRecord
  attr_readonly :user_id, :post_id

  validates :content, presence: true

  belongs_to :author, foreign_key: :author_id, class_name: :User
  belongs_to :post
end
