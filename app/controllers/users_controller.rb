# frozen_string_literal: true

# User Controller; user flow control
class UsersController < ApplicationController
  before_action :authenticate_user!, only: :index

  def show
    @user = User.find(params[:id])
    @user_birthday = get_birthday(@user)
    @user_friends = @user.friends.first(4)
    @recent_posts = @user.authored_posts.first(5)
  end

  def index
    @unkown_users = []
    User.all.each do |friend| 
      @unkown_users << friend if unknown?(friend)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if User.find(params[:id]).update(user_params)
      flash[:notice] = 'Profile updated'
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = "We couldn't update your profile"
      render 'edit'
    end
  end

  private

  def unknown?(user)
    user == current_user ? false : Friendship.where(user: current_user, friend: user).empty?
  end

  def user_params
    params.require(:user).permit(:name, :email, :birth_day, :bio)
  end

  def get_birthday(user)
    return [] if user.birth_day.nil?

    date = user.birth_day.to_s.split('-')
    date[1] = Date::MONTHNAMES[date[1].to_i][0..2]
    date
  end
end
