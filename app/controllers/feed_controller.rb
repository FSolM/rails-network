# frozen_string_literal: true

# Feed Controller; controls the feed of the users
class FeedController < ApplicationController
  def index
    @new_post = Post.new
    @posts = []
    current_user.friends.each { |friend| @post << friend.authored_post } unless current_user&.friends
  end
end
