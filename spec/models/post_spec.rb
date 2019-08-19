require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @post = create(:post)
  end

  context "Unit tests" do
    it "is valid with valid attributes" do
      expect(@post).to be_valid
    end

    it "is invalid without content" do
      post = build(:post, content: nil)
      expect(post).to_not be_valid
    end

    it "is invalid with empty content" do
      post = build(:post, content: '')
      expect(post).to_not be_valid
    end

    it "is invalid without author" do
      post = build(:post, author: nil)
      expect(post).to_not be_valid
    end
  end

  context "Inegration tests" do
    it "post can grab author" do
      user = create(:user, email: 'author_grabbed@example.com')
      post = create(:post, author: user)
      expect(post.author.email).to eql('author_grabbed@example.com')
    end
  end
end