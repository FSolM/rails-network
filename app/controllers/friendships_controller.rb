class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_user, only: %i[add_friend cancel_friend_request decline_friend_request remove_friend accept_friend_request]

  def add_friend
    if current_user.friend?(@user)
      flash[:alert] = "You are already friends"
    else
      if current_user.friendships.create(friend: @user)
        flash[:notice] = "Friend request sent"
      else
        flash[:alert] = "Unexpected error, please try again later"
      end
    end
  end

  def cancel_friend_request
    if current_user.request_sent?(@user)
      if current_user.cancel_friend_request(@user)
        flash[:notice] = "Friend request canceled"
      else
        flash[:alert] = "Unexpected error, please try again later"
      end
    else
      flash[:alert] = "It seems like you haven't sent #{@user.name} a friend request"
    end
  end

  def remove_friend
    if current_user.friend?(@user)
      if current_user.decline_friend(@user)
        flash[:notice] = 'Friend removed'
      else
        flash[:warning] = 'Unexpected error, please try again later'
      end
    else
      flash[:alert] = "It seems like #{@user.name} isn't your friend"
    end
  end

  def accept_friend_request
    current_user.confirm_friend(@user)
  end

  def decline_friend_request
    current_user.decline_friend(@user)
  end

  private
  def search_user
    @user = User.find(params[:user_id])
  end
end
