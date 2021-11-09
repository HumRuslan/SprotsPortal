require 'rails_helper'

RSpec.describe ArticleHelper, type: :helper do
  let!(:article) { FactoryBot.create :article }

  describe "when use article helper" do
    count_word = 50
    it "article long content has been short content a" do
      article_content = 'Article content! ' * 500
      expect(article_short_content(article_content, count_word).split.size).to eq(count_word)
    end

    it "article short content hasn't changed" do
      article_content_short = 'Article content! '
      expect(article_short_content(article_content_short,
                                   count_word).split.size).to eq(article_content_short.split.size)
    end

    it "has human date" do
      expect(human_timestamps(article.updated_at)).to match(%r{[0-9]{2}/[0-9]{2}/[0-9]{4}})
    end
  end
end
