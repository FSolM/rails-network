class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_birthday = get_birthday(@user)
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

  def get_birthday(user)
    birthday = user.birth_day.to_s.split('-')
    case birthday[1]
    when "1"
      birthday[1] = "Jan"
    when "2"
      birthday[1] = "Feb"
    when "3"
      birthday[1] = "Mar"
    when "4"
      birthday[1] = "Apr"
    when "5"
      birthday[1] = "May"
    when "6"
      birthday[1] = "Jun"
    when "7"
      birthday[1] = "Jul"
    when "8"
      birthday[1] = "Aug"
    when "9"
      birthday[1] = "Sep"
    when "10"
      birthday[1] = "Oct"
    when "11"
      birthday[1] = "Nov"
    when "12"
      birthday[1] = "Dic"
    end
    birthday
  end
end
