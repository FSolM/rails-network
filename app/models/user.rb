class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  # Releationships with Post model
  has_many :authored_posts, foreign_key: :author_id, class_name: :Post, dependent: :destroy
end