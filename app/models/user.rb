class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,}
  

  # Releationships with Post model
  has_many :authored_posts, foreign_key: :author_id, class_name: :Post, dependent: :destroy

  # Relationships with Comment model
  has_many :authored_comments, foreign_key: :author_id, class_name: :Comment, dependent: :destroy

  # Relationships with Reaction model
  has_many :reactions, dependent: :destroy
end