require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @author = create(:user)
    @post = create(:post)
    @comment = create(:comment)
  end


  context 'Unit test' do 
    it 'creates a valid comment' do
      expect(@comment).to be_valid
    end
  end
end
