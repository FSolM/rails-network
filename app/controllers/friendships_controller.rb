# frozen_string_literal: true

# Friendships Controller; controls user's friendships, from creating
# to deleting them
class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_user, only: %i[add_friend cancel_friend_request decline
                                       friend_request remove_friend
                                       accept_friend_request]

  def show
    @friends = current_user.friends
    @pending_friends = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def add_friend
    if current_user.friend?(@user)
      flash[:alert] = "You're already friends"
    elsif current_user.request_friendship(@user)
      flash[:notice] = 'Friend request sent'
    else
      flash[:alert] = 'Something went wrong, try again later'
    end
    redirect_back fallback_location: feed_path
  end

  def cancel_friend_request
    if current_user.request_sent?(@user)
      if current_user.cancel_friend_request(@user)
        flash[:notice] = 'Friend request canceled'
      else
        flash[:alert] = 'Unexpected error, please try again later'
      end
    else
      flash[:alert] = "It seems like #{@user.name} is not your friend yet"
    end
    redirect_back fallback_location: feed_path
  end

  def remove_friend
    if current_user.friend?(@user)
      if current_user.delete_friend(@user)
        flash[:notice] = 'Friend removed'
      else
        flash[:warning] = 'Oops! Our bad, please try again'
      end
    else
      flash[:alert] = "It seems like #{@user.name} is not your friend"
    end
    redirect_back fallback_location: feed_path
  end

  def accept_friend_request
    current_user.confirm_friend(@user)
    redirect_back fallback_location: feed_path
  end

  def decline_friend_request
    current_user.decline_friend(@user)
    redirect_back fallback_location: feed_path
  end

  private

  def search_user
    @user = User.find(params[:user_id])
  end
end
