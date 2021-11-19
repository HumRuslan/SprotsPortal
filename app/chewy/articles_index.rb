class ArticlesIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      headline: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  index_scope Article
  field :headline, type: 'text', fielddata: true, analyzer: 'headline'
  field :caption
  field :content
  field :published
  field :created, type: 'date', value: -> { created_at }
end
