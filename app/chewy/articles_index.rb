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
  field :headline, analyzer: 'headline'
  field :caption
  field :content
end
