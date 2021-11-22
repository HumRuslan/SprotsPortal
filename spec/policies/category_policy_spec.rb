require 'rails_helper'

describe Account::Admin::CategoryPolicy do
  subject { described_class }

  permissions :index?, :new?, :create?, :destroy?, :edit?, :update? do
    it "denies access if user login as user" do
      expect(subject).not_to permit(User.new(role: 0), Category.all)
    end

    it "grants access if user login as admin" do
      expect(subject).to permit(User.new(role: 1), Category.all)
    end
  end
end
