class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_comment, only: %i[destroy update]

  def search_comment
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = current_user.authored_comments.build()
  end

  def create
    post = Post.find(params[:id])
    comment = current_user.authored_comments.build(post_params)
    if comment.save
      flash[:notice] = "You have successfully commented a post"
    else
      flash[:alert] = "There has been an error when creating your comment, please try again later"
    end
    redirect_to feed_path
  end

  def destroy
    if @comment.author == current_user
      if @comment.destroy
        flash[:notice] = "You have successfully deleted a comment"
      else
        flash[:alert] = "There has been an error when deleting your comment, please try again later"
      end
    else
      flash[:alert] = "You can't delete a comment that you don't own, please login"
    end
    redirect_to feed_path
  end

  def update
    if @comment.author == current_user
      if @comment.update(patch_params)
        flash[:notice] = "You have successfully edited a comment"
      else
        flash[:alert] = "There has been an error when editing your comment, please try again later"
      end
    else
      flash[:alert] = "You can't edit a comment that you don't own, please login"
    end
    redirect_to feed_path
  end

  private
    def post_params
      new_params = params.require(:post).permit(:content)
      new_params[:post_id] = params[:id]
      new_params
    end

    def patch_params
      params.require(:patch).permit(:content)
    end
end
