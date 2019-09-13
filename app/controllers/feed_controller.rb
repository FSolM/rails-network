# frozen_string_literal: true

# Feed Controller; controls the feed of the users
class FeedController < ApplicationController
  def index
    @recent_posts = Post.all
    @new_post = Post.new
  end
end
