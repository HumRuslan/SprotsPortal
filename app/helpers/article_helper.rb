module ArticleHelper
  def article_short_content(content, length = 50)
    short_content = content.split
    short_content[0..(length - 1)].join(' ')
  end

  def human_timestamps(date)
    Date.strptime(date.to_s).strftime('%d/%m/%Y')
  end
end
