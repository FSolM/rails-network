# frozen_string_literal: true

module ReactionsHelper
  def reacted?(post)
    !Reaction.where(post: post, user: current_user).first.nil?
  end
end
