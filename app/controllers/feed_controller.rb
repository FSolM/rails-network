class FeedController < ApplicationController
  def index
    # Calls Current User And Can Make Posts
    @user = current_user
    @user_friends = User.first(4)
    @recent_posts = Post.order(created_at: :desc)
    @new_post = Post.new()
    puts current_user.name
  end
end
