require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "#create" do
    before(:each) do
      @user = create(:user)
      @post = @user.authored_posts.create(content: 'Created in a laboratory')
      sign_in(@user)
    end

    it "creates a flash when creating a comment" do
      get :create, params: { post: { content: "Created in a laboratory" }, id: @post.id }
      expect(flash[:notice]).to eql("You have successfully commented a post")
    end

    it "redirects correctly after creating a post" do
      get :create, params: { post: { content: "Created in a laboratory" }, id: @post.id }
      expect(response).to redirect_to(feed_path)
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      get :create, params: { post: { content: "Not going to succeed" } }
      expect(flash[:alert]).to eql('You need to sign in or sign up before continuing.')
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      get :create, params: { post: { content: "Not going to succeed" } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#destroy" do
    before(:each) do
      @user = create(:user)
      @post = @user.authored_posts.create(content: 'Created in a laboratory')
      @comment = @user.authored_comments.create(content: 'Comment content', post: @post)
      sign_in(@user)
    end

    it "creates a flash when removing a post" do
      get :destroy, params: { id: @comment.id }
      expect(flash[:notice]).to eql('You have successfully deleted a comment')
    end
    
    it "redirects correctly after removing a post" do
      get :destroy, params: { id: @comment.id }
      expect(response).to redirect_to(feed_path)
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      get :destroy, params: { id: @comment.id }
      expect(flash[:alert]).to eql("You need to sign in or sign up before continuing.")
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      get :destroy, params: { id: @comment.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#update" do
    before(:each) do
      @user = create(:user)
      @post = @user.authored_posts.create(content: 'Created in a laboratory')
      @comment = @user.authored_comments.create(content: 'Comment content', post: @post)
      sign_in(@user)
    end

    it "creates a flash when edited a comment" do
      get :update, params: { id: @comment.id, patch: { content: 'Comment edited in a lab' } }
      expect(flash[:notice]).to eql('You have successfully edited a comment')
    end
    
    it "redirects correctly after removing a comment" do
      get :update, params: { id: @comment.id, patch: { content: 'Comment edited in a lab' } }
      expect(response).to redirect_to(feed_path)
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      get :update, params: { id: @comment.id, patch: { content: 'Post edited in a lab' } }
      expect(flash[:alert]).to eql("You need to sign in or sign up before continuing.")
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      get :update, params: { id: @comment.id, patch: { content: 'Post edited in a lab' } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
