require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#create" do
    before(:each) do
      @user = create(:user)
      sign_in(@user)
    end

    it "creates a flash when creating a post" do
      get :create, params: { post: { content: "Created in a laboratory" } }
      expect(flash[:notice]).to eql('You have successfully created a new post')
    end

    it "redirects correctly after creating a post" do
      get :create, params: { post: { content: "Also created in a laboratory" } }
      expect(response).to redirect_to(feed_path)
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      get :create, params: { post: { content: "Not going to succeed" } }
      expect(flash[:alert]).to eql("You have to log in to post")
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      get :create, params: { post: { content: "Not going to succeed" } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#new" do
    before(:each) do
      @user = create(:user)
      sign_in(@user)
    end

    it 'redirects correctly if the user is not signed in' do
      sign_out(@user)
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#destroy" do
    before(:each) do
      @user = create(:user)
      @post = create(:post, author: @user)
      sign_in(@user)
    end

    it "creates a flash when removing a post" do
      get :destroy, params: { id: @post.id }
      expect(flash[:notice]).to eql('Post deleted successfully')
    end
    
    it "redirects correctly after removing a post" do
      get :destroy, params: { id: @post.id }
      expect(response).to redirect_to(feed_path)
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      get :destroy, params: { id: @post.id }
      expect(flash[:alert]).to eql("Please log in before trying delete a post")
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      get :destroy, params: { id: @post.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#edit" do 
    before(:each) do
      @user = create(:user)
      @post = create(:post, author: @user)
      sign_in(@user)
    end

    it 'assigns correctly @user' do
      get :edit, params: { id: @post.id }
      expect(assigns(:user)).to eql(@user)
    end

    it 'assigns correctly @user_friends' do
      get :edit, params: { id: @post.id }
      expect(assigns(:user_friends).length).to eql(User.last(4).length)
      expect(assigns(:user_friends)[0]).to eql(User.last(4)[0])
    end

    it 'assigns correctly @post' do
      get :edit, params: { id: @post.id }
      expect(assigns(:post)).to eql(@post)
    end

  end

  describe "#update" do
    before(:each) do
      @user = create(:user)
      @post = create(:post, author: @user)
      sign_in(@user)
    end

    it "creates a flash when edited a post a post" do
      get :update, params: { id: @post.id, patch: { content: 'Post edited in a lab' } }
      expect(flash[:notice]).to eql('Post edited successfully')
    end
    
    it "redirects correctly after removing a post" do
      get :update, params: { id: @post.id, patch: { content: 'Post edited in a lab' } }
      expect(response).to redirect_to(feed_path)
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      get :update, params: { id: @post.id, patch: { content: 'Post edited in a lab' } }
      expect(flash[:alert]).to eql("Please log in before trying to edit a post")
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      get :update, params: { id: @post.id, patch: { content: 'Post edited in a lab' } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end