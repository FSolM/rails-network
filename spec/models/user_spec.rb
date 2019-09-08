require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    Friendship.destroy_all
    @user = create(:user)
    @friend = create(:user, email: 'different_email@email.com')
  end
  
  context "Unit tests" do
    context "Sending friend requests" do
      it "can send friend requests" do
        request = @user.friendships.create(friend: @friend)
        expect(request).to be_valid
      end

      it "can't send the same friend request multiple times" do
        request = @user.friendships.create(friend: @friend)
        expect(request).to be_valid
        expect { @user.friendships.create(friend: @friend) }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end

    context "Pending friend requests" do
      it "shows pending friends" do
        @user.friendships.create(friend: @friend)
        expect(@user.pending_friends.first).to eql(@friend)
      end
    end

    context "Friend requests" do
      it "shows friend requests" do
        @user.friendships.create(friend: @friend)
        expect(@friend.friend_requests.first).to eql(@user)
      end
    end

    context "Confirming friend requests" do
      it "confirms a friend requests" do
        @user.friendships.create(friend: @friend)
        expect(@friend.confirm_friend(@user)).to eql(true)
      end

      it "confirms a friend requests only one way" do
        @user.friendships.create(friend: @friend)
        expect(@user.confirm_friend(@friend)).to eql(false)
      end
    end

    context "Showing all friends" do
      it "shows all the friends" do
        @user.friendships.create(friend: @friend)
        @friend.confirm_friend(@user)
        expect(@friend.friends.first.email).to eql(@user.email)
      end
    end

    context "Checking if user is a friend" do
      it "when not accepted" do
        @user.friendships.create(friend: @friend)
        expect(@user.friend?(@friend)).to eql(false)
      end

      it "when accepted" do
        @user.friendships.create(friend: @friend)
        @friend.confirm_friend(@user)
        expect(@friend.friend?(@user)).to eql(true)
      end
    end

    context "Create" do
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

    context "Update" do
      it "updates the bio of a user" do
        user = User.first()
        bio = "This is my new bio :)"
        user.update(bio: bio)
        expect(User.first().bio).to eql(bio)
      end

      it "updates the name of a user" do
        user = User.first()
        name = "My new name"
        user.update(name: name)
        expect(User.first().name).to eql(name)
      end

      it "updates the email of a user" do
        user = User.first()
        email = "creative_email@email.com"
        user.update(email: email)
        expect(User.first().email).to eql(email)
      end

      it "updates the birthday of a user" do
        user = User.first()
        birth_day = Date.new(1970,03,17)

        user.update(birth_day: birth_day)
        expect(User.first().birth_day).to eql(birth_day)

        new_birth_day = Date.new(1976,07,30)
        user.update(birth_day: new_birth_day)
        expect(User.first().birth_day).to eql(new_birth_day)
      end

      it "doesn't update the email of a user when is taken" do
        user = create(:user, email: 'email@email.com')
        used_email = User.first().email
        expect(user.update(email: used_email)).to eql(false)
      end
    end

    context "Delete" do
      it "deletes user correctly" do
        user = User.first()
        user.destroy
        expect(User.first()).to_not eql(user)
      end
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