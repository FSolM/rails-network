class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_friends = User.last(4)
    @recent_posts = @user.authored_posts.first(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if User.find(params[:id]).update(user_params)
      flash[:notice] = "You have successfully updated your profile"
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = "There has been an error while editing your profile, please try again later"
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :bio)
  end
end
