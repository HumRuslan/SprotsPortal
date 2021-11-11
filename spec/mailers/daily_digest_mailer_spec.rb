require "rails_helper"

RSpec.describe DailyDigestMailer, type: :mailer do
  describe "daily digest mailer" do
    let(:user) { FactoryBot.create :user, :confirm }
    let(:article) { FactoryBot.create :article }

    it "renders the headers" do
      article.published
      mail = described_class.with(email: user.email, articles: [article]).daily_digest
      expect(mail.subject).to eq("Daily Digest")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([Rails.application.credentials.email[:user_name]])
    end

    it "renders the body" do
      mail = described_class.with(email: [user.email], articles: [article]).daily_digest
      expect(mail.body.encoded).to match("Daily digest")
    end
  end
end
