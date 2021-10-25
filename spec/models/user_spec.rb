require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create :user }

  it "has a valid factories" do
    expect(user).to be_valid
  end

  specify "must require first name" do
    user.first_name = nil
    expect(user).not_to be_valid
  end

  specify "must require last name" do
    user.last_name = nil
    expect(user).not_to be_valid
  end

  specify "must require email" do
    user.email = nil
    expect(user).not_to be_valid
  end

  specify "email is invalid" do
    user.email = "qqqq"
    expect(user).not_to be_valid
  end

  specify "must require password" do
    user.password = nil
    expect(user).not_to be_valid
  end

  specify "password is invalid" do
    user.password = "qqqq"
    expect(user).not_to be_valid
  end

  it "clears user" do
    user.destroy
    expect(-> { user.reload }).to raise_error(ActiveRecord::RecordNotFound)
  end
end
