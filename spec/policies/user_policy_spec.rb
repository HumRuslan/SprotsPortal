require 'rails_helper'

describe Account::Admin::UserPolicy do
  subject { described_class }

  permissions :users? do
    it "denies access if user login as user" do
      expect(subject).not_to permit(User.new(role: 0), User.all)
    end

    it "grants access if user login as admin" do
      expect(subject).to permit(User.new(role: 1), User.all)
    end
  end
end
