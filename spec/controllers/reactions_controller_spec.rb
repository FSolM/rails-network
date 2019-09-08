require 'rails_helper'

RSpec.describe ReactionsController, type: :controller do
  describe "#create" do
    before(:each) do
      @user = create(:user)
      @post = @user.authored_posts.create(content: 'Created in a laboratory')
      sign_in(@user)
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
end
