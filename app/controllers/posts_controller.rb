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
      end
    else
    end
    redirect_to feed_path
  end

  private
    def post_params
      puts params
      params.require(:post).permit(:content)
    end
end
