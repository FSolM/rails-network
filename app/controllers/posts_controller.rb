class PostsController < ApplicationController
  def new
    if signed_in?
      @post = Post.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    post = current_user.authored_posts.build(post_params)
    puts post
    if post.save
      flash[:notice] = "You have successfully created a new post"
    else
      flash[:alert] = "There has been an error when creating your post, please try again later"
    end
    redirect_to feed_path
  end

  def destroy
    post = Post.find(params[:id])
    if post.author == current_user
      if post.delete
        flash[:notice] = "Post deleted successfully"
      else
        flash[:warning] = "There has been an error deleting your post, please try again later"
      end
    else
      flash[:warning] = "The post you are trying to delete doesn't belong to you"
    end
    redirect_to feed_path
  end

  def edit
    @user = current_user
    @user_friends = User.last(4)
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.author == current_user
      if post.update(patch_params)
        flash[:notice] = "Post edited successfully"
      else
        flash[:warning] = "There has been an error editing your post, please try again later"
      end
    else
      flash[:warning] = "The post you are trying to edit doesn't belong to you"
    end
    redirect_to feed_path
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

    def patch_params
      params.require(:patch).permit(:content)
    end
end
