# frozen_string_literal: true

# Post Record; relationships & validations
class Post < ApplicationRecord
  default_scope { order(created_at: :desc) }

  validates :author, presence: true
  validates :content, presence: true

  belongs_to :author, foreign_key: :author_id, class_name: :User

  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy
end
