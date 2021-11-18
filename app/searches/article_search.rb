class ArticleSearch
  attr_accessor :query, :filters, :orders

  def initialize(params)
    unless params.nil?
      @query = params[:query] if params.key? :query
      @filters = params[:filters].to_hash if params.key? :filters
      @orders = params[:orders].to_hash if params.key? :orders
    end
  end

  FIELDS = %i[headline caption content].freeze

  def result
    ArticlesIndex.query(query_string).filter(filter_string).order(order_string).load
  end

  private

  def query_string
    return { match_all: {} } if @query.nil?

    { query_string: { fields: FIELDS, query: @query, default_operator: 'and' } }
  end

  def filter_string
    return { match_all: {} } if @filters.nil? || @filters.reject { |_key, value| value.empty? }.empty?

    @filters.reject! { |_key, value| value.empty? }
    { term: @filters }
  end

  def order_string
    return { created: { order: :desc } } if @orders.nil?

    order = {}
    @orders.each_pair { |key, value| order[key] = { order: value } }
  end
end
