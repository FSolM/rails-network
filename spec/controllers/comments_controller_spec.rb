require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "#create" do
    before(:each) do
      @user = create(:user)
      @post = @user.authored_posts.create(content: 'Created in a laboratory')
      sign_in(@user)
    end

    it "redirects correctly after creating a comment" do
      post :create, params: { comment: { content: "Created in a laboratory", post_id: @post.id }, post_id: @post.id }
      expect(response).to redirect_to(post_path(@post))
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      post :create, params: { comment: { content: "Created in a laboratory", post_id: @post.id }, post_id: @post.id }
      expect(flash[:alert]).to eql('You need to sign in or sign up before continuing.')
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      post :create, params: { comment: { content: "Created in a laboratory", post_id: @post.id }, post_id: @post.id }
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
      post :destroy, params: { id: @comment.id, post_id: @post.id }
      expect(flash[:notice]).to eql('Your comment has been deleted')
    end
    
    it "redirects correctly after removing a post" do
      post :destroy, params: { id: @comment.id, post_id: @post.id }
      expect(response).to redirect_to(post_path(@post))
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      post :destroy, params: { id: @comment.id, post_id: @post.id }
      expect(flash[:alert]).to eql("You need to sign in or sign up before continuing.")
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      post :destroy, params: { id: @comment.id, post_id: @post.id }
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

    it "redirects correctly after removing a comment" do
      post :update, params: { comment: { content: 'Comment edited in a lab', post_id: @post.id }, 
                              post_id: @post.id, id: @comment.id }
      expect(response).to redirect_to(post_path(@post))
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      post :update, params: { comment: { content: 'Comment edited in a lab', post_id: @post.id }, 
                              post_id: @post.id, id: @comment.id }
      expect(flash[:alert]).to eql("You need to sign in or sign up before continuing.")
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      post :update, params: { comment: { content: 'Comment edited in a lab', post_id: @post.id }, 
                              post_id: @post.id, id: @comment.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
