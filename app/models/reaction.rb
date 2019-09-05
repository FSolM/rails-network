class Reaction < ApplicationRecord
  validates :user_id, uniqueness: { scope: :post_id } 
  validates :reaction_type, presence: true
  attr_readonly :user, :post, :user_id, :post_id

  belongs_to :user
  belongs_to :post
end
