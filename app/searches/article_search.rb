class ArticleSearch
  FIELDS = %i[headline caption content].freeze

  attr_accessor :query, :filters, :orders

  def initialize(params)
    @query = params[:query]
    @filters = params[:filters]
    @orders = params[:orders]
  end

  def result
    ArticlesIndex.query(query_string).filter(filter_string).order(order_string).load
  end

  private

  def query_string
    return match_all if @query.blank?

    { query_string: { fields: FIELDS, query: @query, default_operator: 'and' } }
  end

  def filter_string
    return match_all if @filters.blank? || @filters.compact_blank!.blank?

    result = []
    @filters.to_hash.each { |key, filter| result.push({ term: { key => filter } }) }
    result
  end

  def order_string
    { created: { order: :desc } }
  end

  def match_all
    { match_all: {} }
  end
end
