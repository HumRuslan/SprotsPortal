class DailyDigestMailer < ApplicationMailer
  default from: "Admin Sports Portal <#{Rails.application.credentials.email[:user_name]}>"
  layout 'mailer'

  def daily_digest
    @email = params[:email]
    @articles = params[:articles]
    mail(to: @email, subject: "Daily Digest")
  end
end
