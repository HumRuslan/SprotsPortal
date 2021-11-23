class ArticleSearch
  FIELDS = %i[headline caption content].freeze
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 5

  attr_accessor :query, :filters, :orders

  def initialize(params)
    @query = params[:query]
    @filters = params[:filters]
    @orders = params[:orders]
    @page_current = params[:page] || DEFAULT_PAGE
    @per_page_current = params[:per_page] || DEFAULT_PER_PAGE
  end

  def result
    ArticlesIndex.query(query_string)
                 .filter(filter_string)
                 .order(order_string)
                 .page(@page_current)
                 .per(@per_page_current)
                 .load
  end

  private

  def query_string
    return match_all if @query.blank?

    { query_string: { fields: FIELDS, query: @query, default_operator: 'and' } }
  end

  def filter_string
    return match_all if @filters.blank? || @filters.compact_blank!.blank?

    @filters.to_hash.each_with_object([]) { |(key, filter), result| result.push({ term: { key => filter } }) }
  end

  def order_string
    { created: { order: :desc } }
  end

  def match_all
    { match_all: {} }
  end
end
