class ArticlesIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      headline: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  index_scope Article.includes(:team)
  field :headline, type: 'text', fielddata: true, analyzer: 'headline'
  field :caption
  field :content
  field :published
  field :created, type: 'date', value: -> { created_at }
  field :category_id, type: 'integer', value: ->(article) { article.team.sub_category.category_id }
end
