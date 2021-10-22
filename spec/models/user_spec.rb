require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factories" do
    user = FactoryBot.create :user
    expect(user).to be_valid
  end

  it "must require name" do
    user = FactoryBot.create :user
    user.first_name = nil
    expect(user).not_to be_valid
  end
end
