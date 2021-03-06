# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeedController, type: :controller do
  describe '#index' do
    it 'assigns @recent_posts' do
      create(:post)
      get :index
      expect(assigns(:recent_posts).length).to eql(Post.order(created_at: :desc).length)
      expect(assigns(:recent_posts)[0].id).to eql(Post.order(created_at: :desc)[0].id)
    end

    it 'assigns @new_post' do
      get :index
      expect(assigns(:new_post).class).to eql(Post.new.class)
    end
  end
end
