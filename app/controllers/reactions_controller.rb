# frozen_string_literal: true

# Reactions Controller; controls the likes in posts
class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_reaction, only: :react

  def react
    @reaction.nil? ? create : destroy
  end

  def create
    reaction = current_user.reactions.build(post: @post, reaction_type: 1)
    flash[:alert] = "You can't react to this post" unless reaction.save
  end

  def destroy
    if @reaction.user == current_user
      flash[:alert] = 'Something went wrong' unless @reaction.destroy
    else
      flash[:alert] = "This isn't your like is it?"
    end
  end

  private

  def search_reaction
    @post = Post.find(params[:post_id])
    @reaction = Reaction.where(post: @post, user: current_user).first
  end
end
