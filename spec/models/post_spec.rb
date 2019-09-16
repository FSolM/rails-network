# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @post = create(:post)
  end

  context 'Unit tests' do
    context 'Creation' do
      it 'is valid with valid attributes' do
        expect(@post).to be_valid
      end

      it 'is invalid without content' do
        post = build(:post, content: nil)
        expect(post).to_not be_valid
      end

      it 'is invalid with empty content' do
        post = build(:post, content: '')
        expect(post).to_not be_valid
      end

      it 'is invalid without author' do
        post = build(:post, author: nil)
        expect(post).to_not be_valid
      end
    end

    context 'Updating' do
      it 'updates correctly the content of a post' do
        @post.update(content: 'This is the new content of the post')
        expect(@post.content).to eql('This is the new content of the post')
      end
    end

    context 'Deleting' do
      it 'deletes correctly a post' do
        post = Post.first.destroy
        expect(Post.first).to_not eql(post)
      end
    end
  end

  context 'Integration tests' do
    it 'post can grab author' do
      user = create(:user, email: 'author_grabbed@example.com')
      post = create(:post, author: user)
      expect(post.author.email).to eql('author_grabbed@example.com')
    end
  end
end
