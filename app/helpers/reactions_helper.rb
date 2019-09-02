module ReactionsHelper

  def reacted?(post)
    puts "-----------------> #{Reaction.where(post: post, user: current_user).first.nil?}"
    !Reaction.where(post: post, user: current_user).first.nil?
  end
end
