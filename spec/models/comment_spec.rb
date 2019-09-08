require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @author = create(:user)
    @post = create(:post)
    @comment = @author.authored_comments.create( content: 'created in a lab', post: @post)
  end


  context 'Unit test' do 
    it 'creates a valid comment' do
      expect(@comment).to be_valid
    end

    it 'edits a comment' do
      @comment.update(content: 'New content')
      expect(@comment.content).to eql('New content')
    end

    it 'deletes a comment' do
      @comment.destroy
      expect(@post.comments.length).to eql(0)
    end
  end

  context 'Integration test' do
    it "comment can grab author" do
      user = create(:user, email: 'author_grabbed@example.com')
      comment = user.authored_comments.create( post: @post, content: 'boring content')
      expect(comment.author.email).to eql('author_grabbed@example.com')
    end

    it "reaction can grab post" do
      expect(@comment.post.content).to eql('Same boring content :(')
    end
  end
end
