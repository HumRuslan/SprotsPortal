require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.build :user }

  it 'has full_name' do
    expect(user.full_name).to match("#{user.first_name} #{user.last_name}")
  end
end
