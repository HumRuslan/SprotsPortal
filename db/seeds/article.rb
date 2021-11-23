10.times do
  article = FactoryBot.build :article
  article.save
end
