# frozen_string_literal: true

# Post Controller; everything to do with posting
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_post, only: %i[destroy update edit show]

  def new
    @post = Post.new
  end

  def create
    if current_user.authored_posts.create(post_params)
      redirect_to feed_path
    else
      flash.now[:alert] = "You can't post right now, try again later"
      render 'new'
    end
  end

  def show
    @comments = @post.comments
  end

  def destroy
    if @post.author == current_user
      if @post.destroy
        flash[:notice] = 'Post deleted'
      else
        flash[:alert] = 'Damn! Something went wrong'
      end
    else
      flash[:alert] = 'Are you sure this is your post?'
    end
    redirect_to feed_path
  end

  def edit
    @user_friends = User.last(4)
  end

  def update
    if @post.author == current_user
      if @post.update(post_params)
        flash[:notice] = 'Post updated'
      else
        flash[:alert] = "The post couldn't be updated"
      end
    else
      flash[:alert] = 'Are you sure you can edit THIS post?'
    end
    redirect_to post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def search_post
    @post = Post.find(params[:id])
  end
end
