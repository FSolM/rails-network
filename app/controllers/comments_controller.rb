# frozen_string_literal: true

# Comments Controller; everything related to how comments work in the app
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_comment, only: %i[destroy update edit]
  before_action :search_post, only: %i[create edit update destroy]

  def new
    @post = Post.find(params[:id])
    @comment = @post.comment.build
  end

  def create
    if current_user.authored_comments.create(comment_params)
      redirect_to post_path(@post)
    else
      flash.now[:alert] = 'There has been an error while commenting'
      render 'new'
    end
  end

  def edit; end

  def update
    if @comment.author == current_user && @comment.update(comment_params)
      flash[:alert] = 'Comment updated'
      redirect_to post_path(@post)
    else
      flash.now[:alert] = 'There has been an error when editing your comment'
      render 'edit'
    end
  end

  def destroy
    if @comment.author == current_user
      if @comment.destroy
        flash[:notice] = 'Your comment has been deleted'
      else
        flash[:alert] = 'There has been an error while deleting your comment'
      end
    else
      flash[:alert] = "You can't delete comments that you don't own"
    end
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def search_comment
    @comment = Comment.find(params[:id])
  end

  def search_post
    @post = Post.find(params[:post_id])
  end
end
