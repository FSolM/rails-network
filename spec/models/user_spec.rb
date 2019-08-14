require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create(:user)
  end
  
  it "is valid with valid attributes" do
    expect(@user).to be_valid
  end
  
  it "is invalid with repeted email" do
    user = build(:user)
    expect(user).to_not be_valid
  end

  it "is valid with same name" do
    user = build(:user, email: 'diff_email@email.com')
    expect(user).to be_valid
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