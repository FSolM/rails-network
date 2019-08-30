class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_reaction, only: %i[destroy update]

  def search_reaction
    @reaction = Reaction.find(params[:id])
  end

  def create
    post = Post.find(params[:id])
    reaction = current_user.reactions.build(post_params)
    if reaction.save
      flash[:notice] = "You have successfully reacted to a post"
    else
      flash[:alert] = "There has been an error when reacting, please try again later"
    end
    redirect_to feed_path
  end

  def destroy
    if @reaction.user == current_user
      if @reaction.destroy
        flash[:notice] = "You have successfully deleted your reaction"
      else
        flash[:alert] = "There has been an error when deleting your reaction, please try again later"
      end
    else
      flash[:alert] = "You can't delete a reaction that you don't own, please login"
    end
    redirect_to feed_path
  end

  def update
    if @reaction.user == current_user
      if @reaction.update(patch_params)
        flash[:notice] = "You have successfully edited a reaction"
      else
        flash[:alert] = "There has been an error when editing your reaction, please try again later"
      end
    else
      flash[:alert] = "You can't edit a reaction that you don't own, please login"
    end
    redirect_to feed_path
  end

  private
    def post_params
      new_params = params.require(:post).permit(:reaction_type)
      new_params[:post_id] = params[:id]
      new_params
    end

    def patch_params
      params.require(:patch).permit(:reaction_type)
    end
end
