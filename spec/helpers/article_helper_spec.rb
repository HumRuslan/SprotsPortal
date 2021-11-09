require 'rails_helper'

RSpec.describe ArticleHelper, type: :helper do
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
  end
end
