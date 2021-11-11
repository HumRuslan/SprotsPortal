class DailyDigestWorker
  include Sidekiq::Worker

  def perform
    articles = Article.where('updated_at >= ?', Date.yesterday.beginning_of_day).published
    unless articles.empty?
      User.user.confirmed.active.find_in_batches(batch_size: 50) do |users|
        DailyDigestMailer.with(email: users.pluck(:email), articles: articles).daily_digest.deliver_now
      end
    end
  end
end
