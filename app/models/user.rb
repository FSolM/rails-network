class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,}
  
  has_many :authored_posts, foreign_key: :author_id, class_name: :Post, dependent: :destroy
  has_many :authored_comments, foreign_key: :author_id, class_name: :Comment, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :friendships, dependent: :destroy
  
  # Gets all the friends (accepted)
  def friends
    friendships.where(accepted: true).map { |f| f.friend }.compact
  end

  # Sends a friend request to user
  def request_friendship(user)

    ActiveRecord::Base.transaction do
      friendships.create(friend: user, sender: true)
      user.friendships.create(friend: self, sender: false)
    end
  end

  # Gets all friends that haven't answered the request
  def pending_friends
    friendships.where(accepted: nil).where(sender: true).map { |f| f.friend }.compact
  end

  # Gets all friends that have sent a friend_requests
  def friend_requests
    friendships.where(accepted: nil).where(sender: false).map { |f| f.friend }.compact
  end

  # Confrims the friend request from user
  def confirm_friend(user)
    friendship = friendships.where(friend: user).where(accepted: nil).where(sender: false)
    inverse_friendship = user.friendships.where(friend: self).where(accepted: nil).where(sender: true)
    return false if friendship.empty? || inverse_friendship.empty?

    ActiveRecord::Base.transaction do
      friendship.update(accepted: true)
      inverse_friendship.update(accepted: true)
    end
  end

  # Declines the friend request from user
  def decline_friend(user)
    friendship = friendships.where(friend: user).where(accepted: nil).where(sender: false)
    inverse_friendship = user.friendships.where(friend: self).where(accepted: nil).where(sender: true)
    return false if friendship.empty? || inverse_friendship.empty?

    ActiveRecord::Base.transaction do
      friendship.update(accepted: false)
      inverse_friendship.update(accepted: false)
    end
  end
  
  # Returns true if have sent a friend request to user, false otherwise
  def request_sent?(user)
    !friendships.where(friend: user).where(accepted: nil).where(sender: true).empty?
  end

  # Cancels a sent friend request
  def cancel_friend_request(user)
    friendship = pending_friendship(user)
    inverse_friendship = inverse_pending_friendship(self, user)
    return false if friendship.empty? || inverse_friendship.empty?

    ActiveRecord::Base.transaction do
      Friendship.destroy(friendship.ids)
      Friendship.destroy(inverse_friendship.ids)
    end
  end

  # Deletes user from friends
  def delete_friend(user)
    friendship = accepted_friendship(user)
    inverse_friendship = inverse_accepted_friendship(self, user)
    return false if friendship.empty? || inverse_friendship.empty?

    ActiveRecord::Base.transaction do
      Friendship.destroy(friendship.ids)
      Friendship.destroy(inverse_friendship.ids)
    end
  end

  # Returns true if user is a friend false otherwise
  def friend?(user)
    !friendships.where(friend: user).where(accepted: true).empty?
  end

  private
  
  # Returns the sent friend request (if any) to user that hasn't been answered
  def pending_friendship(user)
    friendships.where(friend: user).where(accepted: nil).where(sender: true)
  end

  # Returns the recieved friend request (if any) from user that hasn't been answered
  def inverse_pending_friendship(user, friend)
    friend.friendships.where(friend: user).where(accepted: nil).where(sender: false)
  end

  # Returns the friendship with user
  def accepted_friendship(user)
    friendships.where(friend: user).where(accepted: true)
  end

  # Returns the friendship with friend from user
  def inverse_accepted_friendship(user, friend)
    friend.friendships.where(friend: user).where(accepted: true)
  end
end
