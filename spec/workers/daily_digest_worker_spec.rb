require 'rails_helper'

RSpec.describe DailyDigestWorker do
  describe "daily digest worker" do
    let(:article) { FactoryBot.create :article }
    let(:user) { FactoryBot.create :user }

    it "job in correct queue" do
      article.published
      user.confirm
      described_class.perform_async
      assert_equal 'default', described_class.queue
    end
  end
end
