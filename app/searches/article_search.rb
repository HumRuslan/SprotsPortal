class ArticleSearch
  include ActiveModel::Model

  attr_accessor :query

  def search
    [query_string].compact.reduce(&:merge)
  end

  def query_string
    if query.present?
      return index.query(query_string: { fields: %i[headline caption content], query: query, default_operator: 'and' })
    end

    index
  end

  private

  def index
    ArticlesIndex
  end
end
