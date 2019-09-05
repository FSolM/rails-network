class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_post, only: %i[destroy update edit show]

  def new
    @post = Post.new
  end

  def create
    post = current_user.authored_posts.build(post_params)
    if post.save
      flash[:notice] = "You have successfully created a new post"
      redirect_to feed_path
    else
      flash.now[:alert] = "There has been an error when creating your post, please try again later"
      render "new"
    end
  end

  def show
    @comments = @post.comments
  end

  def destroy
    if @post.author == current_user
      if @post.destroy
        flash[:notice] = "Post deleted successfully"
      else
        flash[:alert] = "There has been an error deleting your post, please try again later"
      end
      redirect_to feed_path
    else
      flash[:alert] = "Please log in before trying delete a post"
      redirect_to new_user_session_path
    end
  end

  def edit
    @user_friends = User.last(4)
  end

  def update
    if @post.author == current_user
      if @post.update(post_params)
        flash[:notice] = "Post edited successfully"
        redirect_to feed_path
      else
        flash.now[:alert] = "There has been an error editing your post, please try again later"
        render "edit"
      end
    else
      flash[:alert] = "Please log in before trying to edit a post"
      redirect_to new_user_session_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end

  def search_post
    @post = Post.find(params[:id])
  end
end
