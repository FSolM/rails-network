class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_friends = User.last(4)
    @recent_posts = @user.authored_posts
  end

end