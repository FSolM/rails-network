require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create(:user)
  end
  
  context "Unit tests" do
    it "is valid with valid attributes" do
      expect(@user).to be_valid
    end

    it "is valid with same name" do
      user = build(:user, email: 'diff_email@email.com')
      expect(user).to be_valid
    end
    
    it "is invalid with repeted email" do
      user = build(:user)
      expect(user).to_not be_valid
    end

    it "is invalid without name" do
      user = build(:user, name: nil)
      expect(user).to_not be_valid
    end

    it "is invalid without password" do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end

    it "is invalid without email" do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it "is invalid with supershort password" do
      user = build(:user, password: 's')
      expect(user).to_not be_valid
    end
  end

  context "Integration tests" do
    it "user can build a post" do
      create(:post, content: 'user can build a post', author: @user)
      expect(@user.authored_posts.where( content: 'user can build a post')).to_not be_empty
    end

    it "user can build multiple posts" do
      5.times { create(:post, content: 'created in a lab', author: @user) }
      expect(@user.authored_posts.where( content: 'created in a lab').length).to eql(5)
    end

    it "destroys posts when user is destroyed" do
      user = create(:user, email:"posts_when_user_destroyed@email.com")
      post = create(:post, content: 'Soon to be destroyed', author: user)
      user.destroy
      expect(Post.where(author: user).length).to eql(0)
      expect(Post.where(content: 'Soon to be destroyed').length).to eql(0)
    end
  end
end