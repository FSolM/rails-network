class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,}
  
  has_many :authored_posts, foreign_key: :author_id, class_name: :Post, dependent: :destroy
  has_many :authored_comments, foreign_key: :author_id, class_name: :Comment, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships,  class_name: :Friendship, foreign_key: :friend_id
  
  def friends
    friends_array = friendships.map { |friendship| friendship.friend if !friendship.nil? && friendship.accepted }
    friends_array += inverse_friendships.map { |friendship| friendship.user if !friendship.nil? && friendship.accepted }
    friends_array.compact
  end

  def pending_friends
    friendships.map{|friendship| friendship.friend if friendship.accepted.nil? }.compact
  end

  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.accepted}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    return false if friendship.nil?
    friendship.accepted = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
