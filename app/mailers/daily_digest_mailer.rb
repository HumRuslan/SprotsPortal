class DailyDigestMailer < ApplicationMailer
  # default from: "Admin Sports Portal <#{Rails.application.credentials.email[:user_name]}>"
  default from: "Admin Sports Portal <test.ruslan.blog@gmail.com>"
  layout 'mailer'

  def daily_digest
    @email = params[:email]
    @articles = params[:articles]
    mail(to: @email, subject: "Daily Digest")
  end
end
