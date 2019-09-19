# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reaction, type: :model do
  before(:each) do
    @author = create(:user)
    @post = create(:post)
    @reaction = @author.reactions.create(post: @post)
  end

  context 'Unit test' do
    it 'creates a valid reaction' do
      expect(@reaction).to be_valid
    end

    it 'updates a valid reaction' do
      @reaction.update(reaction_type: 1)
      expect(@reaction.reaction_type).to eql(1)
    end

    it 'deletes a valid reaction' do
      @reaction.destroy
      expect(@post.reactions.length).to eql(0)
    end
  end

  context 'Integration test' do
    it 'reaction can grab author' do
      user = create(:user, email: 'author_grabbed@example.com')
      reaction = user.reactions.create(post: @post)
      expect(reaction.user.email).to eql('author_grabbed@example.com')
    end

    it 'reaction can grab post' do
      expect(@reaction.post.content).to eql('Same boring content :(')
    end
  end
end
