class FeedController < ApplicationController
  def index
    @user_friends = User.last(4)  # Friendships not implemented yet (show 4 random users)
    @recent_posts = Post.all
    @new_post = Post.new()
  end
end
