require "rails_helper"

RSpec.describe DailyDigestMailer, type: :mailer do
  describe "daily digest mailer" do
    let(:user) { FactoryBot.create :user }
    let(:article) { FactoryBot.create :article }

    it "renders the headers" do
      user.confirm
      article.published
      mail = described_class.with(email: user.email, articles: [article]).daily_digest
      expect(mail.subject).to eq("Daily Digest")
      expect(mail.to).to eq([user.email])
      # expect(mail.from).to eq([Rails.application.credentials.email[:user_name]])
      expect(mail.from).to eq(['test.ruslan.blog@gmail.com'])
    end

    it "renders the body" do
      user.confirm
      mail = described_class.with(email: [user.email], articles: [article]).daily_digest
      expect(mail.body.encoded).to match("Daily digest")
    end
  end
end
