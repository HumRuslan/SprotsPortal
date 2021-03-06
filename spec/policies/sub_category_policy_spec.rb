require 'rails_helper'

describe Account::Admin::SubCategoryPolicy do
  subject { described_class }

  permissions :new?, :create?, :destroy?, :edit?, :update? do
    it "denies access if user login as user" do
      expect(subject).not_to permit(User.new(role: 0), SubCategory.all)
    end

    it "grants access if user login as admin" do
      expect(subject).to permit(User.new(role: 1), SubCategory.all)
    end
  end
end
