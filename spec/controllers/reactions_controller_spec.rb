require 'rails_helper'

RSpec.describe ReactionsController, type: :controller do
  describe "#create" do
    before(:each) do
      @user = create(:user)
      @post = @user.authored_posts.create(content: 'Created in a laboratory')
      sign_in(@user)
    end


    it "creates a flash when creating a reaction" do
      get :create, params: { post: { reaction_type: 1 }, id: @post.id }
      expect(flash[:notice]).to eql("You have successfully reacted to a post")
    end


    it "redirects correctly after reacting" do
      get :create, params: { post: { reaction_type: 1 }, id: @post.id }
      expect(response).to redirect_to(feed_path)
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      get :create, params: { post: { reaction_type: 1 }, id: @post.id }
      expect(flash[:alert]).to eql('You need to sign in or sign up before continuing.')
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      get :create, params: { post: { reaction_type: 1 }, id: @post.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#destroy" do
    before(:each) do
      @user = create(:user)
      @post = @user.authored_posts.create(content: 'Created in a laboratory')
      @reaction = @user.reactions.create(reaction_type: 1, post: @post)
      sign_in(@user)
    end

    it "creates a flash when removing a reaction" do
      get :destroy, params: { id: @reaction.id }
      expect(flash[:notice]).to eql('You have successfully deleted your reaction')
    end
    
    it "redirects correctly after removing a reaction" do
      get :destroy, params: { id: @reaction.id }
      expect(response).to redirect_to(feed_path)
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      get :destroy, params: { id: @reaction.id }
      expect(flash[:alert]).to eql("You need to sign in or sign up before continuing.")
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      get :destroy, params: { id: @reaction.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "#update" do
    before(:each) do
      @user = create(:user)
      @post = @user.authored_posts.create(content: 'Created in a laboratory')
      @reaction = @user.reactions.create(reaction_type: 1 , post: @post)
      sign_in(@user)
    end

    it "creates a flash when edited a reaction" do
      get :update, params: { id: @reaction.id, patch: { reaction_type: 2 } }
      expect(flash[:notice]).to eql('You have successfully edited a reaction')
    end
    
    it "redirects correctly after removing a reaction" do
      get :update, params: { id: @reaction.id, patch: { reaction_type: 2 } }
      expect(response).to redirect_to(feed_path)
    end

    it "creates a flash when the user is not logged in" do
      sign_out(@user)
      get :update, params: { id: @reaction.id, patch: { reaction_type: 2 } }
      expect(flash[:alert]).to eql("You need to sign in or sign up before continuing.")
    end

    it "redirects correctly when the user is not logged in" do
      sign_out(@user)
      get :update, params: { id: @reaction.id, patch: { reaction_type: 2 } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
