# frozen_string_literal: true

# User Record; relationships & validations
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true
  validates :email, presence: true,
                    format: {
                      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
                    }

  has_many :authored_posts, foreign_key: :author_id,
                            class_name: :Post, dependent: :destroy
  has_many :authored_comments, foreign_key: :author_id,
                               class_name: :Comment, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :friendships, dependent: :destroy

  def friends
    friendships.where(accepted: true).map(&:friend).compact
  end

  def request_friendship(user)
    ActiveRecord::Base.transaction do
      friendships.create(friend: user, sender: true)
      user.friendships.create(friend: self, sender: false)
    end
  end

  def pending_friends
    friendships.where(accepted: nil, sender: true).map(&:friend).compact
  end

  def friend_requests
    friendships.where(accepted: nil, sender: false).map(&:friend).compact
  end

  def confirm_friend(user)
    friendship = friendships.where(friend: user, accepted: nil, sender: false).first
    return false if friendship.nil?

    inverse_friendship = user.friendships.where(friend: self, accepted: nil, sender: true).first
    return false if inverse_friendship.nil?

    ActiveRecord::Base.transaction do
      friendship.update(accepted: true)
      inverse_friendship.update(accepted: true)
    end
  end

  def decline_friend(user)
    friendship = friendships.where(friend: user, accepted: nil, sender: false).first
    return false if friendship.nil?

    inverse_friendship = user.friendships.where(friend: self, accepted: nil, sender: true).first
    return false if inverse_friendship.nil?

    ActiveRecord::Base.transaction do
      friendship.update(accepted: false)
      inverse_friendship.update(accepted: false)
    end
  end

  def request_sent?(user)
    !friendships.where(friend: user, accepted: nil, sender: true).empty?
  end

  def cancel_friend_request(user)
    friendship = pending_friendship(user)
    inverse_friendship = inverse_pending_friendship(self, user)
    return false if friendship.empty? || inverse_friendship.empty?

    ActiveRecord::Base.transaction do
      Friendship.destroy(friendship.ids)
      Friendship.destroy(inverse_friendship.ids)
    end
  end

  def delete_friend(user)
    friendship = accepted_friendship(user)
    inverse_friendship = inverse_accepted_friendship(self, user)
    return false if friendship.empty? || inverse_friendship.empty?

    ActiveRecord::Base.transaction do
      Friendship.destroy(friendship.ids)
      Friendship.destroy(inverse_friendship.ids)
    end
  end

  def friend?(user)
    !friendships.where(friend: user, accepted: true).empty?
  end

  private

  def pending_friendship(user)
    friendships.where(friend: user, accepted: nil, sender: true)
  end

  def inverse_pending_friendship(user, friend)
    friend.friendships.where(friend: user, accepted: nil, sender: false)
  end

  def accepted_friendship(user)
    friendships.where(friend: user, accepted: true)
  end

  def inverse_accepted_friendship(user, friend)
    friend.friendships.where(friend: user, accepted: true)
  end
end
