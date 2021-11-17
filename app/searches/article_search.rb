class ArticleSearch
  # attr_accessor :query, :filter

  def initialize

  end

  def result
    ArticlesIndex.load()
  end

  private

  def query_string
   {
      "match_all": {}
    }
  end

end