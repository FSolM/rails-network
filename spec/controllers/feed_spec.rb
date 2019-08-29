require 'rails_helper'

RSpec.describe FeedController, type: :controller do
  describe "#index" do
    it "assigns @user_friends" do
      create(:user)
      get :index
      expect(assigns(:user_friends).length).to eql(User.last(4).length)
      expect(assigns(:user_friends)[0].id).to eql(User.last(4)[0].id)
    end

    it "assigns @recent_posts" do
      create(:post)
      get :index
      expect(assigns(:recent_posts).length).to eql(Post.order(created_at: :desc).length)
      expect(assigns(:recent_posts)[0].id).to eql(Post.order(created_at: :desc)[0].id)
    end

    it "assigns @new_post" do
      get :index
      expect(assigns(:new_post).class).to eql(Post.new.class)
    end
  end
end