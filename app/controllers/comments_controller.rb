class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_comment, only: %i[destroy update]

  def new
    @post = Post.find(params[:id])
    @comment = @post.comment.build()
  end

  def create
    comment = current_user.authored_comments.build(comment_params)
    if comment.save
      flash[:notice] = "You have successfully commented a post"
      redirect_to post_path(Post.find(params[:post_id]))
    else
      flash.now[:alert] = "There has been an error when creating your comment, please try again later"
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    if @comment.author == current_user
      if @comment.update(patch_params)
        flash[:notice] = "You have successfully edited a comment"
        redirect_to post_path(Post.find(params[:post_id]))
      else
        flash.now[:alert] = "There has been an error when editing your comment, please try again later"
        render "edit"
      end
    else
      flash.now[:alert] = "You can't edit a comment that you don't own, please login"
      render "edit"
    end
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
    redirect_to post_path(Post.find(params[:post_id]))
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def patch_params
    params.require(:patch).permit(:content)
  end

  def search_comment
    @comment = Comment.find(params[:id])
  end
end
