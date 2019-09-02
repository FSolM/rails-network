class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_reaction, only: %i[react]

  def search_reaction
    @post = Post.find(params[:post_id])
    @reaction = Reaction.where(post: @post, user: current_user).first
  end

  def react
    @reaction.nil? ? create : destroy
  end

  def create
    reaction = current_user.reactions.build(post: @post, reaction_type: 1)
    if reaction.save
      flash[:notice] = "You have successfully reacted to a post"
    else
      flash[:alert] = "There has been an error when reacting, please try again later"
    end
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
  end
end
